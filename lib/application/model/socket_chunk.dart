class SocketChunk {
  int sequence;
  List<int> data;

  SocketChunk(this.sequence, this.data);

  factory SocketChunk.fromJson(Map<String, dynamic> json) {
    return SocketChunk(json['secuencia'], json['chunk']);
  }
}
