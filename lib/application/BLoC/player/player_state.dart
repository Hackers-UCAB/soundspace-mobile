part of 'player_bloc.dart';

class PlayerState extends Equatable {
  final List<int> source;
  final List<double> wave;
  final Duration duration;
  final Duration position;
  final bool playbackState;
  final int sequence;
  final int currentStart;
  final int currentEnd;
  final bool isRequired;

  const PlayerState(
      {this.source = const [],
      this.wave = const [],
      this.duration = const Duration(seconds: 1),
      this.position = Duration.zero,
      this.playbackState = false,
      this.sequence = 0,
      this.currentStart = 0,
      this.currentEnd = 0,
      this.isRequired = false});

  PlayerState copyWith(
          {List<int>? source,
          List<double>? wave,
          Duration? duration,
          Duration? position,
          bool? playbackState,
          int? sequence,
          int? currentStart,
          int? currentEnd,
          bool? isRequired}) =>
      PlayerState(
          source: source ?? this.source,
          wave: wave ?? this.wave,
          duration: duration ?? this.duration,
          position: position ?? this.position,
          playbackState: playbackState ?? this.playbackState,
          sequence: sequence ?? this.sequence,
          currentStart: currentStart ?? this.currentStart,
          currentEnd: currentEnd ?? this.currentEnd,
          isRequired: isRequired ?? this.isRequired);

  @override
  List<Object> get props => [
        source,
        wave,
        duration,
        position,
        playbackState,
        sequence,
        currentEnd,
        currentStart,
        isRequired
      ];
}
