part of 'socket_bloc.dart';

abstract class SocketEvent {
  const SocketEvent();
}

class SocketConnected extends SocketEvent {}

class SocketDisconnected extends SocketEvent {}

class SocketReceiveChunk extends SocketEvent {
  final SocketChunck chunck;
  const SocketReceiveChunk(this.chunck);
}

class SocketSendIdSong extends SocketEvent {
  final String idSong;
  const SocketSendIdSong(this.idSong);
}

class SocketReceiveStreamInfo extends SocketEvent {
  final bufferSize;
  const SocketReceiveStreamInfo(this.bufferSize);
}
