part of 'player_bloc.dart';

abstract class PlayerEvent {
  const PlayerEvent();
}

class ReceiveChunkFromSocket extends PlayerEvent {
  SocketChunk chunk;
  ReceiveChunkFromSocket(this.chunk);
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
  final int second;
  AskForChunk(this.second);
}

class InitStream extends PlayerEvent {
  final String songId;
  final int second;
  InitStream(this.songId, this.second);
}

class UpdateInitState extends PlayerEvent {
  final bool isInit;
  UpdateInitState(this.isInit);
}

class UpdateRequiredState extends PlayerEvent {
  final bool isRequired;
  UpdateRequiredState(this.isRequired);
}

class UpdateWaveForm extends PlayerEvent {
  UpdateWaveForm();
}

class UpdateUse extends PlayerEvent {
  UpdateUse();
}

class UpdateLoading extends PlayerEvent {
  final bool isLoading;
  UpdateLoading(this.isLoading);
}

class UpdateSeekPosition extends PlayerEvent {
  final Duration seekPosition;
  UpdateSeekPosition(this.seekPosition);
}
