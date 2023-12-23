import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sign_in_bloc/application/model/socket_chunk.dart';
import '../../services/streaming/socket_client.dart';

part 'socket_event.dart';
part 'socket_state.dart';

class SocketBloc extends Bloc<SocketEvent, SocketState> {
  SocketClient socketClient;
  List<SocketChunck> buffer = [];
  int bufferSize = 0;

  SocketBloc({required this.socketClient}) : super(const SocketState()) {
    on<SocketSendIdSong>(_sendIdSong);
    on<SocketReceiveChunk>(_receiveChunck);
    on<SocketReceiveStreamInfo>(_receiveInfo);
    _receiveBackgroundChunck();
  }

  void _sendIdSong(SocketSendIdSong event, Emitter<SocketState> emit) async {
    socketClient.sendIdSong(event.idSong);
    socketClient.receiveInfo(this);
  }

  Future<void> _receiveChunck(
      SocketReceiveChunk event, Emitter<SocketState> emit) async {
    emit(state.copyWith(buffer: [event.chunck, ...state.buffer]));
  }

  Future<void> _receiveInfo(
      SocketReceiveStreamInfo event, Emitter<SocketState> emit) async {
    emit(state.copyWith(bufferSize: event.bufferSize));
  }

  Future<void> _receiveBackgroundChunck() async {
    socketClient.receiveChunk(this);
  }
}
