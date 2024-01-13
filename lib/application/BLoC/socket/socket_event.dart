part of 'socket_bloc.dart';

abstract class SocketEvent {
  const SocketEvent();
}

class SocketReceiveChunk extends SocketEvent {
  final SocketChunk chunck;
  const SocketReceiveChunk(this.chunck);
}

class SendIdSong extends SocketEvent {
  final String idSong;
  final int second;
  const SendIdSong(this.idSong, this.second);
}

class SendRequiredChunkToPlayer extends SocketEvent {
  final SocketChunk chunck;
  SendRequiredChunkToPlayer(this.chunck);
}
