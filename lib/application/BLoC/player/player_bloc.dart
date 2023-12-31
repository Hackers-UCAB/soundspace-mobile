import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../services/player/player_services.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerService playerService;

  PlayerBloc({required this.playerService}) : super(const PlayerState()) {
    on<PlayerSetSource>(_settingPlayerSource);
    on<PlayerSetWave>(_settingPlayerWave);
    on<PlayerPlaybackStateChanged>(_playbackStateChanged);
    on<TrackingCurrentPosition>(_updatingCurrentPosition);
    on<UpdatingDuration>(_updateDuration);
    on<ResetPlayer>(_resetPlayer);
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

  Future<void> _settingPlayerSource(
      PlayerSetSource event, Emitter<PlayerState> emit) async {
    emit(state.copyWith(source: event.source + state.source));
    await playerService.setAudioSource(event.source);
  }

  Future<void> _settingPlayerWave(
      PlayerSetWave event, Emitter<PlayerState> emit) async {
    emit(state.copyWith(wave: event.wave + state.wave));
  }

  Future<void> play() async {
    playerService.play();
  }

  Future<void> pause() async {
    playerService.pause();
  }
}
