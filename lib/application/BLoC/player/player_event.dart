part of 'player_bloc.dart';

abstract class PlayerEvent {
  const PlayerEvent();
}

class PlayerSetSource extends PlayerEvent {
  final List<int> source;
  PlayerSetSource(this.source);
}

class PlayerSetWave extends PlayerEvent {
  final List<double> wave;
  PlayerSetWave(this.wave);
}

class PlayerPlaybackStateChanged extends PlayerEvent {
  final bool playbackState;
  PlayerPlaybackStateChanged(this.playbackState);
}

class TrackingCurrentPosition extends PlayerEvent {
  final Duration position;
  TrackingCurrentPosition(this.position);
}

class UpdatingDuration extends PlayerEvent {
  final Duration duration;
  UpdatingDuration(this.duration);
}

class ResetPlayer extends PlayerEvent {
  ResetPlayer();
}
