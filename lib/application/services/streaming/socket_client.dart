abstract class SocketClient {
  void inicializeSocket();
  void disconnectSocket();
  void disposeSocket();
  void updateAuth();
  bool isInitializated();
  bool isDisconnected();
  void sendIdSongToServer(
      bool isPreview, String songId, int second, bool isStreaming);
  void receiveChunkFromServer();
}
