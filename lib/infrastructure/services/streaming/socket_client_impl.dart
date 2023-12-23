import 'package:sign_in_bloc/application/model/socket_chunk.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../application/BLoC/socket/socket_bloc.dart';
import '../../../application/services/streaming/socket_client.dart';

class SocketClientImpl extends SocketClient {
  late final IO.Socket socket = IO.io(
      'http://192.168.1.100:5000',
      IO.OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM
          .setExtraHeaders({'foo': 'bar'}) // optional
          .build());

  final List<SocketChunck> buffer = [];

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
  void sendIdSong(String message) {
    socket.emit('idSong', message);
  }

  handleData(dynamic data, dynamic secuence) {
    buffer.add(SocketChunck(secuence: secuence, data: data));
  }

  @override
  void receiveChunk(SocketBloc socketBloc) {
    socket.on('chunck', (data) {
      socketBloc.add(SocketReceiveChunk(
          SocketChunck(secuence: data['secuence'], data: data['payload'])));
    });
  }

  @override
  void receiveInfo(SocketBloc socketBloc) {
    socket.on('info', (data) {
      socketBloc.add(SocketReceiveStreamInfo(data['bufferSize']));
    });
  }
}
