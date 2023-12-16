part of 'socket_bloc.dart';

class SocketState extends Equatable {
  final List<dynamic> buffer;
  final String idSong;

  const SocketState({this.buffer = const [], this.idSong = 'test'});

  SocketState copyWith({List<dynamic>? buffer, String? idSong}) =>
      SocketState(buffer: buffer ?? this.buffer, idSong: idSong ?? this.idSong);

  @override
  List<Object> get props => [buffer, idSong];
}
