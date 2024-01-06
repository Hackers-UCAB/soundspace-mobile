import 'dart:math';

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
  final getIt = GetIt.instance;
  late final MyCustomSource mySource;
  bool aux = true;

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
  Future<void> setAudioSource(SocketChunck chunk) async {
    final playerBloc = getIt.get<PlayerBloc>();

    try {
      concatenatingAudioSource
          .add(AudioSource.uri(Uri.dataFromBytes(chunk.data)));
      if (aux) {
        aux = false;
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
    player.positionStream.listen((position) async {
      if (position.inSeconds ==
              ((playerBloc.state.currentEnd - playerBloc.state.currentStart) -
                  1) &&
          playerBloc.state.isRequired) {
        //print('NUEVO LOAD');
        //print('NUEVA SECUENCIA ${playerBloc.state.sequence + 1}');
        //playerBloc.add(ValidateState(!playerBloc.state.isRequired));
        //if ((playerBloc.state.sequence + 1) < 41) {
        //  playerBloc.add(AskForChunk(playerBloc.state.sequence + 1));
        //}
      }

      if (position.inSeconds == (player.duration!.inSeconds - 1)) {
        playerBloc.add(ValidateState(!playerBloc.state.isRequired));
        if ((playerBloc.state.sequence + 1) < 41) {
          playerBloc.add(AskForChunk(playerBloc.state.sequence + 1));
        }
        //await player.setAudioSource(mySource, preload: true);
      }

      //if (position.inMilliseconds >
      //    (playerBloc.state.currentEnd * 1000) -
      //        (playerBloc.state.currentStart * 1000)) {
      //  playerBloc.add(ValidateState(!playerBloc.state.isRequired));
      //  if ((playerBloc.state.sequence + 1) < 41) {
      //    playerBloc.add(AskForChunk(playerBloc.state.sequence + 1));
      //  }
      //}

      //if (position == player.duration && player.duration! > Duration.zero) {
      //  playerBloc.add(ValidateState(!playerBloc.state.isRequired));
      //  if ((playerBloc.state.sequence + 1) < 41) {
      //    playerBloc.add(AskForChunk(playerBloc.state.sequence + 1));
      //  }
      //}

      print(position);
      print(position == const Duration(seconds: 5, milliseconds: 447));

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
      print(event.playing);
      playerBloc.add(PlayerPlaybackStateChanged(event.playing));
    });

    player.playbackEventStream.listen((event) {
      print(event);
    });
  }

  @override
  void trackingProccesingState() {
    player.processingStateStream.listen((event) async {
      final playerBloc = getIt.get<PlayerBloc>();
      //if (event == ProcessingState.completed) {
      //  playerBloc.add(ValidateState(!playerBloc.state.isRequired));
      //  if ((playerBloc.state.sequence + 1) < 41) {
      //    playerBloc.add(AskForChunk(playerBloc.state.sequence + 1));
      //  }
      //} else if (event == ProcessingState.ready) {
      //  //mySource.addBytes(mySource.bytes);
      //}
    });

    player.bufferedPositionStream.listen((event) async {
      if (event > Duration.zero) {}
    });
  }
}
