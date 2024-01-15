part of 'player_bloc.dart';

class PlayerState extends Equatable {
  final List<double> waveForm;
  final Duration duration;
  final Duration bufferedDuration;
  final Duration position;
  final Duration seekPosition;
  final bool isInit;
  final bool playbackState;
  final bool isUsed;
  final String currentIdSong;
  final String currentNameSong;
  final bool isLoading;

  const PlayerState({
    this.seekPosition = Duration.zero,
    this.isLoading = false,
    this.waveForm = const [0],
    this.isInit = false,
    this.currentIdSong = 'empty',
    this.currentNameSong = 'empty',
    this.duration = const Duration(seconds: 1),
    this.bufferedDuration = Duration.zero,
    this.position = Duration.zero,
    this.playbackState = false,
    this.isUsed = false,
  });

  PlayerState copyWith(
          {bool? isLoading,
          List<double>? waveForm,
          bool? isInit,
          bool? userIsPlaying,
          String? currentIdSong,
          String? currentNameSong,
          Duration? duration,
          Duration? bufferedDuration,
          Duration? position,
          Duration? seekPosition,
          bool? playbackState,
          bool? isUsed}) =>
      PlayerState(
          waveForm: waveForm ?? this.waveForm,
          isInit: isInit ?? this.isInit,
          currentIdSong: currentIdSong ?? this.currentIdSong,
          currentNameSong: currentNameSong ?? this.currentNameSong,
          duration: duration ?? this.duration,
          bufferedDuration: bufferedDuration ?? this.bufferedDuration,
          position: position ?? this.position,
          seekPosition: seekPosition ?? this.seekPosition,
          playbackState: playbackState ?? this.playbackState,
          isUsed: isUsed ?? this.isUsed,
          isLoading: isLoading ?? this.isLoading);

  @override
  List<Object> get props => [
        isInit,
        currentIdSong,
        currentNameSong,
        duration,
        bufferedDuration,
        position,
        seekPosition,
        playbackState,
        waveForm,
        isUsed,
        isLoading
      ];
}
