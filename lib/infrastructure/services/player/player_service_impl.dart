import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sign_in_bloc/application/BLoC/player/player_bloc.dart';
import 'package:sign_in_bloc/application/model/socket_chunk.dart';
import 'package:sign_in_bloc/infrastructure/services/player/custom_source.dart';

import '../../../application/services/player/player_services.dart';

class PlayerServiceImpl extends PlayerService {
  late AudioPlayer player;
  late ByteDataSource byteDataSource;

  ConcatenatingAudioSource concatenatingAudioSource = ConcatenatingAudioSource(
      children: [],
      shuffleOrder: DefaultShuffleOrder(),
      useLazyPreparation: true);

  @override
  void initialize() async {
    player = AudioPlayer();
    trackingBufferedDuration();
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
  Future<void> setAudioSource(SocketChunk chunk) async {
    try {
      if (!GetIt.instance.get<PlayerBloc>().state.isInit) {
        GetIt.instance.get<PlayerBloc>().add(UpdateInitState(true));
        byteDataSource = ByteDataSource();
        await player.setAudioSource(byteDataSource);
        await player.play();
      } else {
        byteDataSource.add(chunk.data);
      }
    } on PlayerInterruptedException catch (e) {
      print("Connection aborted: ${e.message}");
    } catch (e) {
      print(e);
    }
  }

  @override
  void reset() async {
    player.seek(Duration.zero);
    await player.stop();
  }

  @override
  void trackingBufferedDuration() {
    final playerBloc = GetIt.instance.get<PlayerBloc>();
    // TODO es realmente necesario??
    player.bufferedPositionStream.listen((event) async {
      if (event > Duration.zero) {
        playerBloc.add(
            UpdatingBufferedDuration(event + playerBloc.state.seekPosition));
      }
    });
  }

  @override
  void trackingPosition() {
    final playerBloc = GetIt.instance.get<PlayerBloc>();

    player.positionStream.listen((position) async {
      if (player.bufferedPosition > Duration.zero) {
        if ((playerBloc.state.bufferedDuration.inSeconds -
                playerBloc.state.position.inSeconds) ==
            1) {
          player.pause();
          playerBloc.add(ResetPlayer());
        }

        if ((player.bufferedPosition.inSeconds ==
            playerBloc.state.duration.inSeconds)) {
          player.pause();
          playerBloc.add(ResetPlayer());
        }
      }

      playerBloc.add(
          TrackingCurrentPosition(position + playerBloc.state.seekPosition));
    });
  }

  @override
  void clean() async {
    await player.pause();
    await player.stop();

    byteDataSource = ByteDataSource();
  }

  @override
  void setSpeed(double speed) {
    player.setSpeed(speed);
  }

  @override
  void setVolume(double volume) {
    player.setVolume(volume);
  }

  @override
  void trackingState() {
    player.playerStateStream.listen((event) {
      GetIt.instance
          .get<PlayerBloc>()
          .add(PlayerPlaybackStateChanged(event.playing));
      if (!event.playing) {}
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
      }

      if (event == ProcessingState.buffering) {
        GetIt.instance.get<PlayerBloc>().add(UpdateLoading(true));
      }

      if (event == ProcessingState.loading) {
        GetIt.instance.get<PlayerBloc>().add(UpdateLoading(true));
      }

      if (event == ProcessingState.idle) {
        GetIt.instance.get<PlayerBloc>().add(UpdateLoading(false));
      }
    });
  }
}
