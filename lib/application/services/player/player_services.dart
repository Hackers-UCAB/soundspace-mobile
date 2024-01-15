import 'package:sign_in_bloc/application/model/socket_chunk.dart';

abstract class PlayerService {
  void initialize();
  Future<void> setAudioSource(SocketChunk chunk);
  Future<void> play();
  Future<void> pause();
  void setVolume(double volume);
  void setSpeed(double speed);
  void trackingPosition();
  void trackingBufferedDuration();
  void trackingState();
  void trackingProccesingState();
  void reset();
  void clean();
}
