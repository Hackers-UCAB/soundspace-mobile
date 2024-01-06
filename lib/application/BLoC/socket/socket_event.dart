part of 'socket_bloc.dart';

abstract class SocketEvent {
  const SocketEvent();
}

class SocketReceiveChunk extends SocketEvent {
  final SocketChunck chunck;
  const SocketReceiveChunk(this.chunck);
}

class RequiredState extends SocketEvent {
  final bool isRequired;
  RequiredState(this.isRequired);
}

class ReadyState extends SocketEvent {
  final bool isReady;
  ReadyState(this.isReady);
}

class SocketSendIdSong extends SocketEvent {
  final String idSong;
  final int second;
  const SocketSendIdSong(this.idSong, this.second);
}

class RequiredChunk extends SocketEvent {
  final int secuence;
  const RequiredChunk(this.secuence);
}

class SendRequiredChunk extends SocketEvent {
  final SocketChunck chunck;
  SendRequiredChunk(this.chunck);
}

class SocketReceiveStreamInfo extends SocketEvent {
  final bufferSize;
  const SocketReceiveStreamInfo(this.bufferSize);
}
