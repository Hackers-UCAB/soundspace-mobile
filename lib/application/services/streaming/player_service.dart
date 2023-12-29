abstract class PlayerService {
  void initialize();
  Future<void> setAudioSource(List<int> source);
  Future<void> play();
  Future<void> pause();
  Duration currentPosition();
  void seek();
}
