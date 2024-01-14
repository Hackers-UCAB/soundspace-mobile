import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/socket/socket_bloc.dart';
import 'package:sign_in_bloc/application/model/socket_chunk.dart';

import '../../services/player/player_services.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerService playerService;

  PlayerBloc({required this.playerService}) : super(const PlayerState()) {
    on<ReceiveChunkFromSocket>(_setChunkToJustAudio);
    on<PlayerPlaybackStateChanged>(_playbackStateChanged);
    on<TrackingCurrentPosition>(_updatingCurrentPosition);
    on<UpdatingDuration>(_updateDuration);
    on<ResetPlayer>(_resetPlayer);
    on<AskForChunk>(_askForChunk);
    on<InitStream>(_initStream);
    on<UpdateInitState>(_updateInitState);
    on<UpdateRequiredState>(_updateRequiredState);
    on<UpdateWaveForm>(_updateWaveForm);
    on<UpdateUse>(_updateUserUse);
    on<UpdateLoading>(_updateLoading);
    on<UpdateSeekPosition>(_updateSeekPosition);
  }

  void _updateSeekPosition(
      UpdateSeekPosition event, Emitter<PlayerState> emit) {
    emit(state.copyWith(seekPosition: event.seekPosition));
  }

  void _updateLoading(UpdateLoading event, Emitter<PlayerState> emit) {
    emit(state.copyWith(isLoading: event.isLoading));
  }

  void _updateUserUse(UpdateUse event, Emitter<PlayerState> emit) {
    emit(state.copyWith(isUsed: true));
  }

  void _updateWaveForm(UpdateWaveForm event, Emitter<PlayerState> emit) {
    if (state.waveForm.length > 1) {
      emit(state.copyWith(waveForm: [0]));
    } else if (state.waveForm.length == 1) {
      emit(state.copyWith(
          waveForm: List<double>.generate(
              180,
              (i) =>
                  (Random().nextBool() ? 1 : -1) * Random().nextDouble() * 100)
            ..shuffle()));
    }
  }

  void _updateRequiredState(
      UpdateRequiredState event, Emitter<PlayerState> emit) {
    emit(state.copyWith(isRequired: event.isRequired));
  }

  void _updateInitState(UpdateInitState event, Emitter<PlayerState> emit) {
    emit(state.copyWith(isInit: event.isInit));
  }

  void _initStream(InitStream event, Emitter<PlayerState> emit) {
    playerService.clean();
    emit(state.copyWith(
      currentIdSong: event.songId,
      currentNameSong: event.nameSong,
      duration: event.durationSong,
      isInit: false,
    ));
    if (event.second == 0) {
      add(UpdateSeekPosition(Duration.zero));
    } else {
      add(UpdateSeekPosition(Duration(
          minutes: (event.second) ~/ 60, seconds: (event.second) % 60)));
    }

    add(UpdateWaveForm());
    add(UpdateUse());
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
    emit(state.copyWith(position: Duration.zero));
    playerService.reset();
  }

  void _updateDuration(UpdatingDuration event, Emitter<PlayerState> emit) {
    emit(state.copyWith(duration: event.duration));
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
    add(UpdateRequiredState(true));

    await playerService.setAudioSource(event.chunk);
  }

  Future<void> play() async {
    playerService.play();
  }

  Future<void> pause() async {
    playerService.pause();
  }
}
