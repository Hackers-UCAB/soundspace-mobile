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
  List<SocketChunck> buffer = [];
  int bufferSize = 0;

  SocketBloc({required this.socketClient}) : super(const SocketState()) {
    on<SocketSendIdSong>(_sendIdSong);
    on<SocketReceiveChunk>(_receiveChunck);
    on<SocketReceiveStreamInfo>(_receiveInfo);
    on<RequiredChunk>(_requiredChunk);
    on<SendRequiredChunk>(_sendRequiredChunk);
    on<RequiredState>(_setRequiredState);
    on<ReadyState>(_setReadyState);
    _receiveBackgroundChunck();
  }

  void _setRequiredState(RequiredState event, Emitter<SocketState> emit) {
    emit(state.copyWith(isRequired: event.isRequired));
  }

  void _setReadyState(ReadyState event, Emitter<SocketState> emit) {
    emit(state.copyWith(isRequired: event.isReady));
  }

  void _sendRequiredChunk(SendRequiredChunk event, Emitter<SocketState> emit) {
    if (state.isReady && state.isRequired) {
      GetIt.instance.get<PlayerBloc>().add(PlayerSetSource(event.chunck));
      add(ReadyState(!state.isReady));
      add(RequiredState(!state.isRequired));
    }
  }

  void _requiredChunk(RequiredChunk event, Emitter<SocketState> emit) async {
    emit(state.copyWith(requiredSequence: event.secuence));

    state.buffer.forEach((element) {
      if (element.sequence == event.secuence) {
        add(SendRequiredChunk(element));
      }
    });
    //GetIt.instance.get<PlayerBloc>().add(PlayerSetSource(state.buffer
    //    .firstWhere((element) => element.sequence == event.secuence)));
  }

  void _sendIdSong(SocketSendIdSong event, Emitter<SocketState> emit) async {
    socketClient.sendIdSong(event.idSong, event.second);
    //socketClient.receiveInfo(this);
  }

  Future<void> _receiveChunck(
      SocketReceiveChunk event, Emitter<SocketState> emit) async {
    emit(state.copyWith(buffer: [event.chunck, ...state.buffer]));
    if (state.requiredSequence == event.chunck.sequence) {
      add(SendRequiredChunk(event.chunck));
    }
  }

  Future<void> _receiveInfo(
      SocketReceiveStreamInfo event, Emitter<SocketState> emit) async {
    emit(state.copyWith(bufferSize: event.bufferSize));
  }

  Future<void> _receiveBackgroundChunck() async {
    socketClient.receiveChunk(this);
  }
}
