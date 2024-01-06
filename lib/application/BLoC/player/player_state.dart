part of 'player_bloc.dart';

class PlayerState extends Equatable {
  final Duration duration;
  final Duration position;
  final bool isInit;
  final bool isRequired;
  final bool playbackState;
  final int currentStart;
  final int latestStart;
  final int currentEnd;
  final String currentIdSong;

  const PlayerState({
    this.isInit = false,
    this.isRequired = false,
    this.currentIdSong = 'empty',
    this.duration = const Duration(seconds: 1),
    this.position = Duration.zero,
    this.playbackState = false,
    this.currentStart = 0,
    this.latestStart = 0,
    this.currentEnd = 0,
  });

  PlayerState copyWith(
          {bool? isInit,
          bool? isRequired,
          String? currentIdSong,
          Duration? duration,
          Duration? position,
          bool? playbackState,
          int? currentStart,
          int? latestStart,
          int? currentEnd}) =>
      PlayerState(
        isRequired: isRequired ?? this.isRequired,
        isInit: isInit ?? this.isInit,
        currentIdSong: currentIdSong ?? this.currentIdSong,
        duration: duration ?? this.duration,
        position: position ?? this.position,
        playbackState: playbackState ?? this.playbackState,
        currentStart: currentStart ?? this.currentStart,
        latestStart: currentStart ?? this.latestStart,
        currentEnd: currentEnd ?? this.currentEnd,
      );

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
        isRequired
      ];
}
