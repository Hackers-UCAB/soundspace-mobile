part of 'socket_bloc.dart';

class SocketState extends Equatable {
  final List<SocketChunck> buffer;
  final String idSong;
  final int bufferSize;

  const SocketState(
      {this.bufferSize = 0, this.buffer = const [], this.idSong = 'test'});

  SocketState copyWith(
          {List<SocketChunck>? buffer, String? idSong, int? bufferSize}) =>
      SocketState(
          bufferSize: bufferSize ?? this.bufferSize,
          buffer: buffer ?? this.buffer,
          idSong: idSong ?? this.idSong);

  @override
  List<Object> get props => [buffer, idSong];
}
