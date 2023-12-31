class SocketChunck {
  int sequence;
  List<int> data;

  SocketChunck(this.sequence, this.data);

  factory SocketChunck.fromJson(Map<String, dynamic> json) {
    return SocketChunck(
      json['secuencia'],
      json['chunk'],
    );
  }
}
