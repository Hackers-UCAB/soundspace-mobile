import 'dart:async';
import 'dart:typed_data';

import 'package:just_audio/just_audio.dart';

class ByteDataSource extends StreamAudioSource {
  StreamController<Uint8List> streamControllerBuffer =
      StreamController<Uint8List>.broadcast();

  void add(Uint8List data) {
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
