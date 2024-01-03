import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sign_in_bloc/application/BLoC/player/player_bloc.dart';
import 'package:sign_in_bloc/application/model/socket_chunk.dart';
import 'package:sign_in_bloc/infrastructure/services/player/custom_source.dart';

import '../../../application/services/player/player_services.dart';

class PlayerServiceImpl extends PlayerService {
  late final AudioPlayer player;
  final getIt = GetIt.instance;
  late final MyCustomSource mySource;

  @override
  void initialize() {
    player = AudioPlayer();
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
  Future<void> setAudioSource(SocketChunck chunk) async {
    final playerBloc = getIt.get<PlayerBloc>();
    try {
      mySource.addBytes(chunk.data);

      await player.setAudioSource(
        mySource,
        preload: true,
      );

      await player.load();

      if (player.processingState == ProcessingState.ready) {
        play();
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
    final playerBloc = getIt.get<PlayerBloc>();
    playerBloc.add(
        UpdatingDuration(Duration(minutes: 3, seconds: 13, milliseconds: 54)));

    player.durationStream.listen((duration) {
      print('duracion actual ${duration}');
      //if (duration! > Duration.zero) {
      //  playerBloc.add(UpdatingDuration(duration));
      //}

      //playerBloc.add(UpdatingDuration(
      //    Duration(minutes: 13, seconds: 13, milliseconds: 54)));
    });
  }

  @override
  void trackingPosition() {
    final playerBloc = getIt.get<PlayerBloc>();
    player.positionStream.listen((position) {
      if (position.inSeconds ==
              ((playerBloc.state.currentEnd - playerBloc.state.currentStart) -
                  1) &&
          playerBloc.state.isRequired) {
        print('NUEVO LOAD');
        print('NUEVA SECUENCIA ${playerBloc.state.sequence + 1}');
        playerBloc.add(ValidateState(!playerBloc.state.isRequired));
        if ((playerBloc.state.sequence + 1) < 21) {
          playerBloc.add(AskForChunk(playerBloc.state.sequence + 1));
        }
      }

      print("position tracking ${position.inMilliseconds}");
      print(
          "position tracking start - end + position ${(playerBloc.state.currentEnd - playerBloc.state.currentStart) - 1}");

      print(
          "position tracking position final ${playerBloc.state.currentStart + position.inSeconds}");
      if (position > Duration.zero) {
        print(
            'duracion para la barra ${Duration(minutes: (playerBloc.state.currentStart + position.inSeconds) ~/ 60, seconds: (playerBloc.state.currentStart + position.inSeconds) % 60)}');
        playerBloc.add(TrackingCurrentPosition(Duration(
            minutes: (playerBloc.state.currentStart + position.inSeconds) ~/ 60,
            seconds:
                (playerBloc.state.currentStart + position.inSeconds) % 60)));
      }
    });
  }

  @override
  void trackingState() {
    final playerBloc = getIt.get<PlayerBloc>();
    player.playerStateStream.listen((event) {
      playerBloc.add(PlayerPlaybackStateChanged(event.playing));
    });
  }

  @override
  void trackingProccesingState() {
    player.processingStateStream.listen((event) {});
  }
}
