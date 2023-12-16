import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sign_in_bloc/application/model/socket_chunk.dart';
import '../../services/streaming/socket_client.dart';

part 'socket_event.dart';
part 'socket_state.dart';

class SocketBloc extends Bloc<SocketEvent, SocketState> {
  SocketClient socketClient;

  SocketBloc({required this.socketClient}) : super(const SocketState()) {
    on<SocketSend>(_sendIdSong);
    on<SocketReceive>(_receiveChunck);
    _receiveBackgroundChunck();
  }

  void _sendIdSong(SocketSend event, Emitter<SocketState> emit) {
    socketClient.sendMessage(event.idSong);
  }

  Future<void> _receiveChunck(
      SocketReceive event, Emitter<SocketState> emit) async {
    emit(state.copyWith(buffer: [...state.buffer, event.chunck]));
    state.buffer;
  }

  Future<void> _receiveBackgroundChunck() async {
    SocketChunck chunck = SocketChunck(secuence: '', data: 'data');
    socketClient.getSocket().on(
        'chunck',
        (data) => {
              print(data['secuence']),
              chunck.secuence = data['secuence'],
              chunck.data = data['payload'],
              if (chunck.secuence != '') add(SocketReceive(chunck)),
            });
  }
}
