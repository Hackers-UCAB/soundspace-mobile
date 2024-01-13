import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/player/player_bloc.dart';
import 'package:sign_in_bloc/application/model/socket_chunk.dart';
import '../../services/streaming/socket_client.dart';

part 'socket_event.dart';
part 'socket_state.dart';

class SocketBloc extends Bloc<SocketEvent, SocketState> {
  SocketClient socketClient;

  SocketBloc({required this.socketClient}) : super(const SocketState()) {
    on<SendIdSong>(_sendIdSongToServer);
    on<SocketReceiveChunk>(_receiveChunkFromServer);
    on<SendRequiredChunkToPlayer>(_sendRequiredChunkToPlayer);
    _receiveBackgroundChunck();
  }

  void _sendRequiredChunkToPlayer(
      SendRequiredChunkToPlayer event, Emitter<SocketState> emit) {
    GetIt.instance.get<PlayerBloc>().add(ReceiveChunkFromSocket(event.chunck));
  }

  void _sendIdSongToServer(SendIdSong event, Emitter<SocketState> emit) async {
    //se debe agregar el primer atributo como el permiso del usuario para traer el preview o no
    socketClient.sendIdSongToServer(
        true, event.idSong, event.second, state.streamingMode);
  }

  Future<void> _receiveChunkFromServer(
      SocketReceiveChunk event, Emitter<SocketState> emit) async {
    add(SendRequiredChunkToPlayer(event.chunck));
  }

  Future<void> _receiveBackgroundChunck() async {
    socketClient.receiveChunkFromServer();
  }
}
