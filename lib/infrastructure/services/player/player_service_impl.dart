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
  late final ByteDataSource mySource;

  @override
  void initialize() async {
    player = AudioPlayer();
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
    try {
      concatenatingAudioSource
          .add(AudioSource.uri(Uri.dataFromBytes(chunk.data)));

      if (!GetIt.instance.get<PlayerBloc>().state.isInit) {
        GetIt.instance.get<PlayerBloc>().add(UpdateInitState(true));
        await player.setAudioSource(concatenatingAudioSource,
            preload: true,
            initialIndex: 0,
            initialPosition:
                GetIt.instance.get<PlayerBloc>().state.seekPosition);
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
    player.durationStream.listen((duration) {
      print('DURACION ACTUAL ${duration?.inSeconds}');
    });
  }

  @override
  void trackingPosition() {
    final playerBloc = GetIt.instance.get<PlayerBloc>();

    player.positionStream.listen((position) async {
      //print(playerBloc.state.position);
      //if (player.duration != null) {
      //  if (((player.duration!.inSeconds - position.inSeconds) == 4) &&
      //      playerBloc.state.isRequired) {
      //    if (player.sequence != null && player.currentIndex != null) {
      //      var totalDuration = Duration.zero;
      //      for (var i = 0; i < player.currentIndex!; i++) {
      //        totalDuration += player.sequence![i].duration!;
      //      }
      //      totalDuration += player.position + playerBloc.state.seekPosition;
      //      GetIt.instance.get<PlayerBloc>().add(UpdateRequiredState(
      //          !GetIt.instance.get<PlayerBloc>().state.isRequired));
      //      print("TOTAL DURATION ${totalDuration}");
      //      print("TOTAL DURATION ${playerBloc.state.position}");
      //      GetIt.instance
      //          .get<PlayerBloc>()
      //          .add(AskForChunk(totalDuration.inSeconds));
      //    }
      //  }
      //}

      //if (player.sequence != null && player.currentIndex != null) {
      //  var totalDuration = Duration.zero;
      //  for (var i = 0; i < player.currentIndex!; i++) {
      //    totalDuration += player.sequence![i].duration!;
      //  }
      //  totalDuration += player.position + playerBloc.state.seekPosition;
      //  playerBloc.add(TrackingCurrentPosition(totalDuration));
      //}
    });
  }

  void clean() {
    player.pause();
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
      if (event == ProcessingState.ready) {
        GetIt.instance.get<PlayerBloc>().add(UpdateLoading(false));
      } else if (event != ProcessingState.completed) {
        GetIt.instance.get<PlayerBloc>().add(UpdateLoading(true));
      }
    });
  }
}
