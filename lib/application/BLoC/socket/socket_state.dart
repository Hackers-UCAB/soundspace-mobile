part of 'socket_bloc.dart';

class SocketState extends Equatable {
  final List<SocketChunck> buffer;
  final String idSong;
  final int bufferSize;
  final bool isRequired;
  final bool isReady;
  final int requiredSequence;

  const SocketState(
      {this.bufferSize = 0,
      this.buffer = const [],
      this.idSong = 'test',
      this.isRequired = true,
      this.isReady = true,
      this.requiredSequence = 0});

  SocketState copyWith(
          {List<SocketChunck>? buffer,
          String? idSong,
          int? bufferSize,
          bool? isRequired,
          bool? isReady,
          int? requiredSequence}) =>
      SocketState(
          bufferSize: bufferSize ?? this.bufferSize,
          buffer: buffer ?? this.buffer,
          idSong: idSong ?? this.idSong,
          isRequired: isRequired ?? this.isRequired,
          isReady: isReady ?? this.isReady,
          requiredSequence: requiredSequence ?? this.requiredSequence);

  @override
  List<Object> get props =>
      [buffer, idSong, isRequired, isReady, requiredSequence];
}
