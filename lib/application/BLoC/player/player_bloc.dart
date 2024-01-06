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
    on<PlayerSetWave>(_settingPlayerWave);
    on<PlayerPlaybackStateChanged>(_playbackStateChanged);
    on<TrackingCurrentPosition>(_updatingCurrentPosition);
    on<UpdatingDuration>(_updateDuration);
    on<ResetPlayer>(_resetPlayer);
    on<AskForChunk>(_askForChunk);
    on<InitStream>(_initStream);
    on<UpdateInitState>(_updateInitState);
    on<UpdateRequiredState>(_updateRequiredState);
    on<UpdateLatestStart>(_updateLatestStart);
  }

  void _updateLatestStart(UpdateLatestStart event, Emitter<PlayerState> emit) {
    emit(state.copyWith(latestStart: event.latestStart));
  }

  void _updateRequiredState(
      UpdateRequiredState event, Emitter<PlayerState> emit) {
    emit(state.copyWith(isRequired: event.isRequired));
  }

  void _updateInitState(UpdateInitState event, Emitter<PlayerState> emit) {
    emit(state.copyWith(isInit: event.isInit));
  }

  void _initStream(InitStream event, Emitter<PlayerState> emit) {
    emit(state.copyWith(currentIdSong: event.songId, isInit: false));
    playerService.clean();
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
    emit(state.copyWith(
        currentEnd: event.chunk.end, currentStart: event.chunk.start));
    await playerService.setAudioSource(event.chunk);
  }

  Future<void> _settingPlayerWave(
      PlayerSetWave event, Emitter<PlayerState> emit) async {}

  Future<void> play() async {
    playerService.play();
  }

  Future<void> pause() async {
    playerService.pause();
  }
}
