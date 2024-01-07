part of 'player_bloc.dart';

class PlayerState extends Equatable {
  final List<double> waveForm;
  final Duration duration;
  final Duration position;
  final bool isInit;
  final bool isRequired;
  final bool playbackState;
  final bool isUsed;
  final int currentStart;
  final int latestStart;
  final int currentEnd;
  final String currentIdSong;
  final bool isLoading;

  const PlayerState({
    this.isLoading = false,
    this.waveForm = const [0],
    this.isInit = false,
    this.isRequired = false,
    this.currentIdSong = 'empty',
    this.duration = const Duration(seconds: 1),
    this.position = Duration.zero,
    this.playbackState = false,
    this.isUsed = false,
    this.currentStart = 0,
    this.latestStart = 0,
    this.currentEnd = 0,
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
          bool? playbackState,
          int? currentStart,
          int? latestStart,
          int? currentEnd,
          bool? isUsed}) =>
      PlayerState(
          waveForm: waveForm ?? this.waveForm,
          isRequired: isRequired ?? this.isRequired,
          isInit: isInit ?? this.isInit,
          currentIdSong: currentIdSong ?? this.currentIdSong,
          duration: duration ?? this.duration,
          position: position ?? this.position,
          playbackState: playbackState ?? this.playbackState,
          currentStart: currentStart ?? this.currentStart,
          latestStart: latestStart ?? this.latestStart,
          currentEnd: currentEnd ?? this.currentEnd,
          isUsed: isUsed ?? this.isUsed,
          isLoading: isLoading ?? this.isLoading);

  @override
  List<Object> get props => [
        isInit,
        currentIdSong,
        duration,
        position,
        playbackState,
        currentEnd,
        currentStart,
        latestStart,
        isRequired,
        waveForm,
        isUsed,
        isLoading
      ];
}
