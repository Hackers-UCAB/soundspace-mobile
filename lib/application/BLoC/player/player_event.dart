part of 'player_bloc.dart';

abstract class PlayerEvent {
  const PlayerEvent();
}

class PlayerSetSource extends PlayerEvent {
  final SocketChunck chunk;
  PlayerSetSource(this.chunk);
}

class ValidateState extends PlayerEvent {
  final bool isRequired;
  ValidateState(this.isRequired);
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

class AskForChunk extends PlayerEvent {
  final int secuencia;
  AskForChunk(this.secuencia);
}

class InitStream extends PlayerEvent {
  final String songId;
  InitStream(this.songId);
}
