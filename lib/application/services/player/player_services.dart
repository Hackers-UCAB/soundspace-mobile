abstract class PlayerService {
  void initialize();
  Future<void> setAudioSource(List<int> source);
  Future<void> play();
  Future<void> pause();
  void trackingPosition();
  void trackingDuration();
  void trackingState();
  void reset();
  void seek(Duration duration);
}
