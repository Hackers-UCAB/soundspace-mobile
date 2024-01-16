import 'dart:typed_data';

class SocketChunk {
  Uint8List data;

  SocketChunk(this.data);

  factory SocketChunk.fromJson(Map<String, dynamic> json) {
    return SocketChunk(json['chunk']);
  }
}
