import 'dart:async';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/datasources/local/local_storage.dart';
import 'package:sign_in_bloc/application/model/socket_chunk.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../application/BLoC/socket/socket_bloc.dart';
import '../../../application/services/streaming/socket_client.dart';

class SocketClientImpl extends SocketClient {
  LocalStorage localStorage;

  SocketClientImpl({required this.localStorage});

  late final IO.Socket socket; // = IO.io(
  //'https://soundspace-api-production-3d1f.up.railway.app/socket.io/socket.io.js',
  //IO.OptionBuilder().setTransports(['websocket']).build());

  @override
  void inicializeSocket() async {
    //socket = IO.io('http://192.168.1.101:5000',
    //    IO.OptionBuilder().setTransports(['websocket']).build());

    //socket = IO.io(url, <String, dynamic>{
    //  'transports': ['websocket', 'polling'],
    //  'path': '/socket.io',
    //  'auth': ''
    //});

    print(localStorage.getValue('appToken'));

    String url = 'https://soundspace-api-production-3d1f.up.railway.app';

    socket = IO.io(
        url,
        IO.OptionBuilder()
            .setTransports(['websocket', 'polling'])
            .setPath('/socket.io')
            .setAuth({'token': localStorage.getValue('appToken')})
            .build());

    socket.connect();

    socket.onError((data) => print('error de socket ${data}'));

    socket.onConnect((_) {
      print('connect');
    });
  }

  @override
  void sendIdSongToServer(
      bool isPreview, String songId, int second, bool isStreaming) {
    socket.emit('message-from-client', {
      'preview': isPreview,
      'songId': songId,
      'second': second,
      'streaming': isStreaming
    });
  }

  @override
  void receiveChunkFromServer() async {
    final streamController = StreamController<SocketChunk>();

    socket.on('message-from-server', (data) {
      streamController.add(SocketChunk.fromJson(data));
    });

    streamController.stream.listen((chunk) async {
      GetIt.instance.get<SocketBloc>().add(SocketReceiveChunk(chunk));
    });
  }
}
