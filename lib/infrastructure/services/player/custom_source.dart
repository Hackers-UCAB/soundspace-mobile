import 'dart:async';

import 'package:just_audio/just_audio.dart';

class ByteDataSource extends StreamAudioSource {
  StreamController<List<int>> streamControllerBuffer =
      StreamController<List<int>>.broadcast();

  void add(List<int> data) {
    if (data.isNotEmpty) {
      streamControllerBuffer.add(data);
    }
  }

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    return StreamAudioResponse(
      sourceLength: null,
      contentLength: null,
      offset: start ?? 0,
      stream: streamControllerBuffer.stream,
      contentType: 'audio/mpeg',
    );
  }
}
