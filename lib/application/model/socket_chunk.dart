class SocketChunk {
  int sequence;
  int start;
  int end;
  List<int> data;

  SocketChunk(this.sequence, this.data, this.start, this.end);

  factory SocketChunk.fromJson(Map<String, dynamic> json) {
    return SocketChunk(
        json['secuencia'], json['chunk'], json['start'], json['end']);
  }
}
