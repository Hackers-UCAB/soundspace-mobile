part of 'socket_bloc.dart';

class SocketState extends Equatable {
  final String idSong;
  final bool streamingMode;

  const SocketState({this.idSong = 'empty', this.streamingMode = false});

  SocketState copyWith({
    bool? streamingMode,
    String? idSong,
  }) =>
      SocketState(idSong: idSong ?? this.idSong);

  @override
  List<Object> get props => [idSong, streamingMode];
}
