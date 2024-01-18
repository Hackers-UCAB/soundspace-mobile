import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/socket/socket_bloc.dart';
import 'package:sign_in_bloc/application/model/socket_chunk.dart';
import 'package:sign_in_bloc/application/services/internet_connection/connection_manager.dart';
import 'package:sign_in_bloc/domain/song/song.dart';

import '../../services/player/player_services.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerService playerService;
  final IConnectionManager connectionManager;

  PlayerBloc({required this.playerService, required this.connectionManager})
      : super(const PlayerState()) {
    on<ReceiveChunkFromSocket>(_setChunkToJustAudio);
    on<PlayerPlaybackStateChanged>(_playbackStateChanged);
    on<TrackingCurrentPosition>(_updatingCurrentPosition);
    on<UpdatingBufferedDuration>(_updateDuration);
    on<ResetPlayer>(_resetPlayer);
    on<AskForChunk>(_askForChunk);
    on<InitStream>(_initStream);
    on<UpdateInitState>(_updateInitState);
    on<UpdateWaveForm>(_updateWaveForm);
    on<UpdateUse>(_updateUserUse);
    on<UpdateLoading>(_updateLoading);
    on<UpdateSeekPosition>(_updateSeekPosition);
    on<UpdateSpeed>(_updateSpeed);
    on<UpdateVolume>(_updateVolume);
    on<UpdateFinish>(_updateFinish);
    on<ConnectivityCheckRequestedPlayer>(_checkInitialConnection);
    on<UpdateConnection>(_updateConnection);
    on<RefreshPlayer>(_onRefresh);
    on<UpdatePlaylist>(_updatePlaylist);

    add(ConnectivityCheckRequestedPlayer());
  }

  void _updatePlaylist(UpdatePlaylist event, Emitter<PlayerState> emit) {
    emit(state.copyWith(playlist: event.playlist));
  }

  void _onRefresh(RefreshPlayer event, Emitter<PlayerState> emit) {
    emit(state.copyWith(
        seekPosition: Duration.zero,
        isLoading: false,
        playlist: [],
        waveForm: const [0],
        isInit: true,
        isRefresh: true,
        currentIdSong: 'empty',
        currentNameSong: 'empty',
        duration: const Duration(seconds: 1),
        bufferedDuration: Duration.zero,
        position: Duration.zero,
        isUsed: false,
        isFinished: true,
        playbackState: true,
        isConnected: true,
        speed: 1.0,
        volume: 1.0));

    playerService.setSpeed(1);
    playerService.setVolume(1);
  }

  void handleDisconnection() {
    //primer paso pausa el stream
    pause();

    //se bloquean los botones
    add(UpdateConnection(false));
  }

  void handleReconnection() {
    //se pregunta si estaba iniciado el stream
    if (state.isInit) {
      add(InitStream(state.currentIdSong, state.position.inSeconds,
          state.currentNameSong, state.duration));
    }

    add(UpdateConnection(true));
  }

  void _updateConnection(UpdateConnection event, Emitter<PlayerState> emit) {
    emit(state.copyWith(isConnected: event.isConnected));
  }

  void _checkInitialConnection(
      ConnectivityCheckRequestedPlayer event, Emitter<PlayerState> emit) async {
    final subscriptionStream = connectionManager.checkConnectionStream();
    await for (final isConnected in subscriptionStream) {
      isConnected ? handleReconnection() : handleDisconnection();
    }
  }

  void _updateFinish(UpdateFinish event, Emitter<PlayerState> emit) {
    emit(state.copyWith(isFinished: event.isFinished));
  }

  void _updateSpeed(UpdateSpeed event, Emitter<PlayerState> emit) {
    emit(state.copyWith(speed: event.speed));
    playerService.setSpeed(event.speed);
  }

  void _updateVolume(UpdateVolume event, Emitter<PlayerState> emit) {
    emit(state.copyWith(volume: event.volume));
    playerService.setVolume(event.volume);
  }

  void _updateSeekPosition(
      UpdateSeekPosition event, Emitter<PlayerState> emit) {
    emit(state.copyWith(seekPosition: event.seekPosition));
  }

  void _updateLoading(UpdateLoading event, Emitter<PlayerState> emit) {
    emit(state.copyWith(isLoading: event.isLoading));
  }

  void _updateUserUse(UpdateUse event, Emitter<PlayerState> emit) {
    emit(state.copyWith(isUsed: event.isUsed));
  }

  void _updateWaveForm(UpdateWaveForm event, Emitter<PlayerState> emit) {
    emit(state.copyWith(
        waveForm: List<double>.generate(80,
            (i) => (Random().nextBool() ? 1 : -1) * Random().nextDouble() * 100)
          ..shuffle()));
  }

  void _updateInitState(UpdateInitState event, Emitter<PlayerState> emit) {
    emit(state.copyWith(isInit: event.isInit));
  }

  void _initStream(InitStream event, Emitter<PlayerState> emit) {
    playerService.clean();

    if (event.songId != state.currentIdSong) {
      add(UpdateWaveForm());
    }

    emit(state.copyWith(
      currentIdSong: event.songId,
      currentNameSong: event.nameSong,
      duration: event.durationSong,
      isInit: false,
      isFinished: false,
      isRefresh: false,
    ));
    if (event.second == 0) {
      add(UpdateSeekPosition(Duration.zero));
    } else {
      add(UpdateSeekPosition(Duration(
          minutes: (event.second) ~/ 60, seconds: (event.second) % 60)));
    }

    add(const UpdateUse(isUsed: true));

    GetIt.instance
        .get<SocketBloc>()
        .add(SendIdSong(event.songId, event.second));
  }

  void _askForChunk(AskForChunk event, Emitter<PlayerState> emit) {
    GetIt.instance
        .get<SocketBloc>()
        .add(SendIdSong(state.currentIdSong, event.second));
  }

  void _resetPlayer(ResetPlayer event, Emitter<PlayerState> emit) {
    emit(state.copyWith(
        position: Duration.zero,
        seekPosition: Duration.zero,
        bufferedDuration: Duration.zero));

    playerService.reset();

    //si tiene una playlist guardada
    if (state.playlist.isNotEmpty) {
      //si esta reproduciendo alguna cancion de esa playlist
      if (state.playlist.any((song) => song.id == state.currentIdSong)) {
        //posicion en la playlist
        var index =
            state.playlist.indexWhere((song) => song.id == state.currentIdSong);
        //si no es la ultima de la playlist
        if (index + 1 < state.playlist.length) {
          //inicia la siguente
          add(InitStream(
              state.playlist[index + 1].id,
              0,
              state.playlist[index + 1].name,
              Duration(
                  minutes: int.parse(
                      state.playlist[index + 1].duration!.split(':')[0]),
                  seconds: int.parse(
                      state.playlist[index + 1].duration!.split(':')[1]))));
        }
        //si es la ultima de la playlist
        else {
          emit(state.copyWith(isUsed: false));
        }
      }
      // si no esta reproduciendo una cancion de la playlist
      else {
        emit(state.copyWith(isUsed: false));
      }
    }
    //si no tiene una playlist guardada
    else {
      emit(state.copyWith(isUsed: false));
    }
  }

  void _updateDuration(
      UpdatingBufferedDuration event, Emitter<PlayerState> emit) {
    emit(state.copyWith(bufferedDuration: event.bufferedDuration));
  }

  void _updatingCurrentPosition(
      TrackingCurrentPosition event, Emitter<PlayerState> emit) {
    emit(state.copyWith(position: event.position));
  }

  void _playbackStateChanged(
      PlayerPlaybackStateChanged event, Emitter<PlayerState> emit) {
    emit(state.copyWith(playbackState: event.playbackState));

    if (event.playbackState) {
      play();
    } else {
      pause();
    }
  }

  Future<void> _setChunkToJustAudio(
      ReceiveChunkFromSocket event, Emitter<PlayerState> emit) async {
    await playerService.setAudioSource(event.chunk);
  }

  Future<void> play() async {
    playerService.play();
  }

  Future<void> pause() async {
    playerService.pause();
  }
}
