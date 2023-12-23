import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:typed_data';

import '../../../application/BLoC/socket/socket_bloc.dart';

class MyCustomSource extends StreamAudioSource {
  final Uint8List bytes;
  MyCustomSource(this.bytes);

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    start ??= 0;
    end ??= bytes.length;
    return StreamAudioResponse(
      sourceLength: bytes.length,
      contentLength: end - start,
      offset: start,
      stream: Stream.fromIterable([bytes.sublist(start, end)]),
      contentType: 'audio/mp3',
    );
  }
}

class MusicPlayer extends StatelessWidget {
  MusicPlayer({super.key});
  final player = AudioPlayer();

  void load(dynamic test) async {
    final source = await player.setAudioSource(MyCustomSource(test));
    player.play();
  }

  Future<void> copy(BytesBuilder bytes) async {
    await bytes.toBytes();
  }

  @override
  Widget build(BuildContext context) {
    final buffer =
        context.select((SocketBloc socketBloc) => socketBloc.state.buffer);
    final bufferSize =
        context.select((SocketBloc socketBloc) => socketBloc.state.bufferSize);

    if (buffer.length >= bufferSize && buffer.isNotEmpty) {
      var bytesBuilder = BytesBuilder();
      for (var chunk in buffer) {
        bytesBuilder.add(chunk.data);
      }

      load(bytesBuilder.toBytes());
    }

    return Container(
      // ?
      height: 60,
      width: double.infinity,
      decoration: const BoxDecoration(color: Color.fromARGB(255, 24, 15, 35)),
      child: Column(
        children: [
          const LinearProgressIndicator(
            backgroundColor: Color.fromARGB(255, 33, 31, 34),
            value:
                0.2, //porcentaje que debe coincidir con el porcentaje que va de audio
            minHeight: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                const Icon(
                  Icons.play_circle_fill,
                  size: 50,
                  color: Color(0xff1de1ee),
                ),
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(children: [
                    Text(
                      buffer.length.toString(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ]),
                ),
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '1:00',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(width: 6),
                      const Icon(
                        Icons.play_arrow_sharp,
                        color: Color(0xff1de1ee),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
