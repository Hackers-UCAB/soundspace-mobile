import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/player/player_bloc.dart';
import 'package:sign_in_bloc/application/datasources/local/local_storage.dart';
import 'package:sign_in_bloc/application/model/socket_chunk.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../application/BLoC/socket/socket_bloc.dart';
import '../../../application/services/streaming/socket_client.dart';

class SocketClientImpl extends SocketClient {
  LocalStorage localStorage;
  bool _isInitializated = false;
  bool _isDisconnected = false;
  SocketClientImpl({required this.localStorage});

  late IO.Socket socket;

  @override
  void inicializeSocket() async {
    // NO MUY HEXAGONAL LO SE PERO HAY QUE RESOLVER, ME ENTIENDEN?
    if (dotenv.env['TEAM']! == 'HACKERS') {
      print('tokeeeeeen ${localStorage.getValue('appToken')}');
      socket = IO.io(dotenv.env['SOCKET_SERVER']!, <String, dynamic>{
        'auth': {
          'token': localStorage.getValue('appToken').toString(),
        },
        'path': dotenv.env['PATH'].toString(),
        'transports': ['websocket'],
      });

      //socket = IO.io(
      //    dotenv.env['SOCKET_SERVER']!,
      //    IO.OptionBuilder()
      //        .setTransports(['websocket', 'polling'])
      //        .setAuth({'token': localStorage.getValue('appToken')})
      //        .setPath(dotenv.env['PATH'].toString())
      //        .build());
    } else if (dotenv.env['TEAM']! == 'GEEKS') {
      socket = IO.io(dotenv.env['SOCKET_SERVER']!, <String, dynamic>{
        'transports': ['websocket'],
        'auth': {'token': localStorage.getValue('appToken').toString()},
      });
    }
    print('inicializa ${socket.auth}');
    socket.auth;

    socket.connect();

    socket.onError((data) => print('error de socket ${data}'));

    socket.onConnect((_) {
      print('connect');
    });

    _isInitializated = true;
    _isDisconnected = false;
  }

  void setAuth() {}

  @override
  void sendIdSongToServer(
      bool isPreview, String songId, int second, bool isStreaming) {
    socket.emit('message-from-client', {
      'preview': false,
      'songId': songId,
      'second': second,
      'streaming': isStreaming
    });
  }

  @override
  void receiveChunkFromServer() async {
    final streamController = StreamController<SocketChunk>();

    socket.on('message-from-server', (data) {
      if (data['chunk'].isNotEmpty &&
          !GetIt.instance.get<PlayerBloc>().state.isRefresh) {
        streamController.add(SocketChunk.fromJson(data));
      } else if (data['chunk'].isEmpty) {
        print('finaliza');
        GetIt.instance.get<PlayerBloc>().add(UpdateFinish(true));
      }
    });

    streamController.stream.listen((chunk) async {
      GetIt.instance.get<SocketBloc>().add(SocketReceiveChunk(chunk));
    });
  }

  @override
  bool isInitializated() {
    return _isInitializated;
  }

  @override
  void disconnectSocket() {
    socket.disconnect();
    _isDisconnected = true;
  }

  @override
  bool isDisconnected() {
    return _isDisconnected;
  }

  @override
  void disposeSocket() {
    socket.dispose();
  }

  @override
  updateAuth() {
    print(socket.io.options!['auth']);
    socket.disconnect();
    socket.auth['token'] = localStorage.getValue('appToken').toString();
    socket.connect();
    print('actualiza ${socket.auth}');
  }
}
