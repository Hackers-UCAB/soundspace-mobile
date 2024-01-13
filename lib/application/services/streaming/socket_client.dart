abstract class SocketClient {
  void inicializeSocket();
  void sendIdSongToServer(
      bool isPreview, String songId, int second, bool isStreaming);
  void receiveChunkFromServer();
}
