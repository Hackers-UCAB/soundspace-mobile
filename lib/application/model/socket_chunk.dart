class SocketChunck {
  int sequence;
  int start;
  int end;
  List<int> data;

  SocketChunck(this.sequence, this.data, this.start, this.end);

  factory SocketChunck.fromJson(Map<String, dynamic> json) {
    return SocketChunck(
        json['secuencia'], json['chunk'], json['start'], json['end']);
  }
}
