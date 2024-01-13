import 'dart:typed_data';

class SocketChunk {
  List<int> data;

  SocketChunk(this.data);

  factory SocketChunk.fromJson(Map<String, dynamic> json) {
    return SocketChunk(json['chunk']);
  }
}
