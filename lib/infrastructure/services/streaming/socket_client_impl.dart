import 'dart:async';
import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/player/player_bloc.dart';
import 'package:sign_in_bloc/application/datasources/local/local_storage.dart';
import 'package:sign_in_bloc/application/model/socket_chunk.dart';
import 'package:sign_in_bloc/infrastructure/datasources/local/local_storage_impl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../application/BLoC/socket/socket_bloc.dart';
import '../../../application/services/streaming/socket_client.dart';

class SocketClientImpl extends SocketClient {
  LocalStorage localStorage;

  SocketClientImpl({required this.localStorage});
  //final channel = WebSocketChannel.connect(
  //  Uri.parse('wss://soundspace-api-production-3d1f.up.railway.app:3000/'),
  //);

  late final IO.Socket socket; // = IO.io(
  //'https://soundspace-api-production-3d1f.up.railway.app/socket.io/socket.io.js',
  //IO.OptionBuilder().setTransports(['websocket']).build());

  @override
  void inicializeSocket() async {
    //socket = IO.io('http://192.168.1.106:5000',
    //    IO.OptionBuilder().setTransports(['websocket']).build());

    String url = 'https://soundspace-api-production-3d1f.up.railway.app';

    //socket = IO.io(url, <String, dynamic>{
    //  'transports': ['websocket', 'polling'],
    //  'path': '/socket.io',
    //  'auth': ''
    //});

    print(localStorage.getValue('appToken'));

    socket = IO.io(
        url,
        IO.OptionBuilder()
            .setTransports(['websocket', 'polling'])
            .setPath('/socket.io')
            .setAuth({
              'token':
                  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImE5NGY4MTc2LTY5MjktNDY5NC05NDhjLTU0OGI5OTgxNGMxMSIsImlhdCI6MTcwMzg5ODg3MiwiZXhwIjoxNzAzOTg1MjcyfQ.9xeYaG4H_XOSe2QTYZdwnzZ5_Iuu_sSjnsvYDF3SPlc'
            })
            .build());

    socket.connect();

    socket.onError((data) => print('error de socket ${data}'));

    socket.onConnect((_) {
      print('connect');
    });
  }

  @override
  void sendIdSong(String message) {
    socket.emit('message-from-client',
        {'preview': true, 'songId': message, 'second': 100});
  }

  @override
  void receiveChunk(SocketBloc socketBloc) async {
    final getIt = GetIt.instance;
    final playerBloc = getIt.get<PlayerBloc>();
    final streamController = StreamController<SocketChunck>();

    socket.on('message-from-server', (data) {
      streamController.add(SocketChunck.fromJson(data));
    });

    streamController.stream.listen((chunk) async {
      socketBloc.add(SocketReceiveChunk(chunk));
      playerBloc.add(PlayerSetSource(chunk.data));
    });
  }

  @override
  void receiveInfo(SocketBloc socketBloc) {
    socket.on('info', (data) {
      socketBloc.add(SocketReceiveStreamInfo(data['bufferSize']));
    });
  }
}
