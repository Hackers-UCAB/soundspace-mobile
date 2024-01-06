import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sign_in_bloc/application/BLoC/player/player_bloc.dart';
import 'package:sign_in_bloc/application/model/socket_chunk.dart';
import 'package:sign_in_bloc/infrastructure/services/player/custom_source.dart';
import '../../../application/services/player/player_services.dart';

class PlayerServiceImpl extends PlayerService {
  late final AudioPlayer player;
  late final ConcatenatingAudioSource concatenatingAudioSource =
      ConcatenatingAudioSource(
          children: [],
          shuffleOrder: DefaultShuffleOrder(),
          useLazyPreparation: true);
  late final MyCustomSource mySource;

  @override
  void initialize() async {
    player = AudioPlayer(handleInterruptions: false);
    mySource = MyCustomSource();
    trackingDuration();
    trackingPosition();
    trackingState();
    trackingProccesingState();
  }

  @override
  Future<void> pause() async {
    if (player.playing) {
      await player.pause();
    }
  }

  @override
  Future<void> play() async {
    if (!player.playing) {
      await player.play();
    }
  }

  @override
  void seek(Duration duration) {
    player.seek(duration);
  }

  @override
  Future<void> setAudioSource(SocketChunk chunk) async {
    print('SECUENCIA ACTUAL ${chunk.sequence}');
    try {
      concatenatingAudioSource
          .add(AudioSource.uri(Uri.dataFromBytes(chunk.data)));

      if (!GetIt.instance.get<PlayerBloc>().state.isInit) {
        print('ENTRAAAAAAAAAAAAA');
        GetIt.instance.get<PlayerBloc>().add(UpdateInitState(true));
        await player.setAudioSource(concatenatingAudioSource, preload: true);
        await player.load();

        if (player.processingState == ProcessingState.ready) {
          play();
        }
      }
    } on PlayerInterruptedException catch (e) {
      print("Connection aborted: ${e.message}");
    } catch (e) {
      print(e);
    }
  }

  @override
  void reset() {
    player.seek(Duration.zero);
    player.stop();
  }

  @override
  void trackingDuration() {
    GetIt.instance.get<PlayerBloc>().add(
        UpdatingDuration(Duration(minutes: 3, seconds: 13, milliseconds: 54)));

    // TODO es realmente necesario??
    player.durationStream.listen((duration) {});
  }

  @override
  void trackingPosition() {
    final playerBloc = GetIt.instance.get<PlayerBloc>();
    player.positionStream.listen((position) async {
      if ((playerBloc.state.currentEnd - playerBloc.state.currentStart) -
                  position.inSeconds ==
              3 &&
          playerBloc.state.isRequired) {
        GetIt.instance.get<PlayerBloc>().add(UpdateRequiredState(
            !GetIt.instance.get<PlayerBloc>().state.isRequired));
        GetIt.instance.get<PlayerBloc>().add(
            AskForChunk(GetIt.instance.get<PlayerBloc>().state.currentEnd + 1));
      }

      if (position == player.duration && position > Duration.zero) {
        playerBloc.add(UpdateLatestStart(playerBloc.state.currentStart));
      }

      if (position > Duration.zero) {
        //playerBloc.add(TrackingCurrentPosition(Duration(
        //    minutes: (playerBloc.state.latestStart + position.inSeconds) ~/ 60,
        //    seconds:
        //        (playerBloc.state.latestStart + position.inSeconds) % 60)));
      }
    });
  }

  void clean() {
    player.stop();
    concatenatingAudioSource.clear();
  }

  @override
  void trackingState() {
    player.playerStateStream.listen((event) {
      GetIt.instance
          .get<PlayerBloc>()
          .add(PlayerPlaybackStateChanged(event.playing));
    });

    player.playbackEventStream.listen((event) {
      print(event);
    });
  }

  @override
  void trackingProccesingState() {
    player.processingStateStream.listen((event) async {
      if (event == ProcessingState.completed) {}
    });
  }
}
