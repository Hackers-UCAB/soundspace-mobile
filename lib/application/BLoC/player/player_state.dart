part of 'player_bloc.dart';

class PlayerState extends Equatable {
  final List<int> source;
  final List<double> wave;
  final Duration duration;
  final Duration position;
  final bool playbackState;

  const PlayerState(
      {this.source = const [],
      this.wave = const [],
      this.duration = const Duration(seconds: 1),
      this.position = Duration.zero,
      this.playbackState = false});

  PlayerState copyWith(
          {List<int>? source,
          List<double>? wave,
          Duration? duration,
          Duration? position,
          bool? playbackState}) =>
      PlayerState(
          source: source ?? this.source,
          wave: wave ?? this.wave,
          duration: duration ?? this.duration,
          position: position ?? this.position,
          playbackState: playbackState ?? this.playbackState);

  @override
  List<Object> get props => [source, wave, duration, position, playbackState];
}
