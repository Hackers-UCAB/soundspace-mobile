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

class UpdatingBufferedDuration extends PlayerEvent {
  final Duration bufferedDuration;
  UpdatingBufferedDuration(this.bufferedDuration);
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
  final String nameSong;
  final Duration durationSong;
  final int second;
  InitStream(this.songId, this.second, this.nameSong, this.durationSong);
}

class UpdateInitState extends PlayerEvent {
  final bool isInit;
  UpdateInitState(this.isInit);
}

class UpdateWaveForm extends PlayerEvent {
  UpdateWaveForm();
}

class UpdateUse extends PlayerEvent {
  final bool isUsed;
  const UpdateUse({required this.isUsed});
}

class UpdateLoading extends PlayerEvent {
  final bool isLoading;
  UpdateLoading(this.isLoading);
}

class UpdateSeekPosition extends PlayerEvent {
  final Duration seekPosition;
  UpdateSeekPosition(this.seekPosition);
}

class UpdateVolume extends PlayerEvent {
  final double volume;
  UpdateVolume(this.volume);
}

class UpdateSpeed extends PlayerEvent {
  final double speed;
  UpdateSpeed(this.speed);
}

class UpdateFinish extends PlayerEvent {
  final bool isFinished;
  UpdateFinish(this.isFinished);
}

class ConnectivityCheckRequestedPlayer extends PlayerEvent {}

class UpdateConnection extends PlayerEvent {
  final bool isConnected;
  UpdateConnection(this.isConnected);
}

class UpdatePlaylist extends PlayerEvent {
  final List<Song> playlist;
  UpdatePlaylist(this.playlist);
}

class RefreshPlayer extends PlayerEvent {}
