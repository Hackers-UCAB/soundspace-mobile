import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../application/services/streaming/socket_client.dart';

class SocketClientImpl extends SocketClient {
  late final IO.Socket socket = IO.io(
      'http://192.168.1.102:5000',
      IO.OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM
          .setExtraHeaders({'foo': 'bar'}) // optional
          .build());

  @override
  void inicializeSocket() {
    socket.connect();
    socket.onConnect((_) {
      print('connect');
    });
  }

  void handleReceive(data, chunck, state) {
    print(data);
    chunck.secuence = data['secuence'];
    chunck.data = data['payload'];
    //emit(state.copyWith(buffer: [chunck, ...state.buffer]));
  }

  @override
  void sendMessage(String message) {
    socket.emit('idSong', message);
  }

  @override
  IO.Socket getSocket() {
    return socket;
  }
}
