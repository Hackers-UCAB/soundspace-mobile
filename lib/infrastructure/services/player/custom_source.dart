import 'dart:typed_data';

import 'package:just_audio/just_audio.dart';

class ByteDataSource extends StreamAudioSource {
  final Uint8List data;
  ByteDataSource(this.data);

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    start ??= 0;
    end ??= data.length;
    return StreamAudioResponse(
      sourceLength: data.length,
      contentLength: end - start,
      offset: start,
      stream: Stream.value(data.sublist(start, end)),
      contentType: 'audio/mpeg',
    );
  }
}
