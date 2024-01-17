abstract class SocketClient {
  void inicializeSocket();
  void disconnectSocket();
  bool isInitializated();
  bool isDisconnected();
  void sendIdSongToServer(
      bool isPreview, String songId, int second, bool isStreaming);
  void receiveChunkFromServer();
}
