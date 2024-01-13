part of 'player_bloc.dart';

class PlayerState extends Equatable {
  final List<double> waveForm;
  final Duration duration;
  final Duration position;
  final Duration seekPosition;
  final bool isInit;
  final bool isRequired;
  final bool playbackState;
  final bool isUsed;
  final String currentIdSong;
  final bool isLoading;

  const PlayerState({
    this.seekPosition = Duration.zero,
    this.isLoading = false,
    this.waveForm = const [0],
    this.isInit = false,
    this.isRequired = false,
    this.currentIdSong = 'empty',
    this.duration = const Duration(seconds: 1),
    this.position = Duration.zero,
    this.playbackState = false,
    this.isUsed = false,
  });

  PlayerState copyWith(
          {bool? isLoading,
          List<double>? waveForm,
          bool? isInit,
          bool? isRequired,
          bool? userIsPlaying,
          String? currentIdSong,
          Duration? duration,
          Duration? position,
          Duration? seekPosition,
          bool? playbackState,
          bool? isUsed}) =>
      PlayerState(
          waveForm: waveForm ?? this.waveForm,
          isRequired: isRequired ?? this.isRequired,
          isInit: isInit ?? this.isInit,
          currentIdSong: currentIdSong ?? this.currentIdSong,
          duration: duration ?? this.duration,
          position: position ?? this.position,
          seekPosition: seekPosition ?? this.seekPosition,
          playbackState: playbackState ?? this.playbackState,
          isUsed: isUsed ?? this.isUsed,
          isLoading: isLoading ?? this.isLoading);

  @override
  List<Object> get props => [
        isInit,
        currentIdSong,
        duration,
        position,
        seekPosition,
        playbackState,
        isRequired,
        waveForm,
        isUsed,
        isLoading
      ];
}
