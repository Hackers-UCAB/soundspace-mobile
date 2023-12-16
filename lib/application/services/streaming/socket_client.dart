import 'package:socket_io_client/socket_io_client.dart' as IO;

abstract class SocketClient {
  void inicializeSocket();
  void sendMessage(String message);
  IO.Socket getSocket();
}
