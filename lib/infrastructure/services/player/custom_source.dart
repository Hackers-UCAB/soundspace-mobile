import 'package:just_audio/just_audio.dart';

class MyCustomSource extends StreamAudioSource {
  MyCustomSource();
  List<int> _bytes = [];

  void addBytes(List<int> bytes) {
    //_bytes = bytes;
    _bytes.addAll(bytes);
  }

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    start ??= 0;
    end ??= _bytes.length;
    return StreamAudioResponse(
      sourceLength: _bytes.length,
      contentLength: end - start,
      offset: start,
      stream: Stream.value(_bytes.sublist(start, end)),
      contentType: 'audio/mp3',
    );
  }
}
