import 'package:sign_in_bloc/application/model/socket_chunk.dart';

abstract class PlayerService {
  void initialize();
  Future<void> setAudioSource(SocketChunck chunk);
  Future<void> play();
  Future<void> pause();
  void trackingPosition();
  void trackingDuration();
  void trackingState();
  void trackingProccesingState();
  void reset();
  void seek(Duration duration);
}
