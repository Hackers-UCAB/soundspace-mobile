import 'dart:math';

import 'package:flutter/material.dart';
import 'package:general_audio_waveforms/general_audio_waveforms.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/player/player_bloc.dart';
import '../../../application/BLoC/socket/socket_bloc.dart';

class MusicPlayer extends StatelessWidget {
  const MusicPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final socketBloc = GetIt.instance.get<SocketBloc>();
    final playerBloc = GetIt.instance.get<PlayerBloc>();
    var addMinuteZero = '0';
    var addSecondZero = '0';

    if (playerBloc.state.position.inMinutes.toString().length < 2) {
      addMinuteZero = '0';
    } else {
      addMinuteZero = '';
    }

    if ((playerBloc.state.position.inSeconds % 60).toString().length < 2) {
      addSecondZero = '0';
    } else {
      addSecondZero = '';
    }
    var list = List<double>.generate(180,
        (i) => (Random().nextBool() ? 1 : -1) * Random().nextDouble() * 100)
      ..shuffle();

    if (((playerBloc.state.position.inSeconds.toDouble() /
                playerBloc.state.duration.inSeconds.toDouble()) *
            100.toDouble()) >
        99.5) {
      playerBloc.add(ResetPlayer());
    }

    return Container(
      height: 200,
      width: double.infinity,
      decoration: const BoxDecoration(color: Color.fromARGB(255, 24, 15, 35)),
      child: Column(
        children: [
          LinearProgressIndicator(
            backgroundColor: const Color.fromARGB(255, 33, 31, 34),
            value: playerBloc.state.position.inSeconds.toDouble() /
                playerBloc.state.duration.inSeconds
                    .toDouble(), //porcentaje que debe coincidir con el porcentaje que va de audio
            minHeight: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () => {
                    playerBloc.add(PlayerPlaybackStateChanged(
                        !playerBloc.state.playbackState))
                  },
                  icon: const Icon(
                    Icons.play_circle_fill,
                    size: 50,
                    color: Color(0xff1de1ee),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(children: [
                    Text(
                      'Artist',
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  ]),
                ),
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '$addMinuteZero${playerBloc.state.position.inMinutes}:$addSecondZero${playerBloc.state.position.inSeconds % 60}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(width: 6),
                      IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () => {
                          playerBloc.add(
                            InitStream(
                                'ac75ed9c-4f69-4c59-a4cc-8843c8a33108', 0),
                          )
                        },
                        icon: const Icon(
                          Icons.play_arrow_sharp,
                          color: Color(0xff1de1ee),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          GeneralAudioWaveform(
            scalingAlgorithmType: ScalingAlgorithmType.median,
            waveformType: WaveformType.rectangle,
            height: 80,
            width: 400,
            maxSamples: list.length,
            source: AudioDataSource(samples: list),
            maxDuration: Duration(minutes: 3, seconds: 13),
            elapsedDuration: playerBloc.state.position,
            elapsedIsChanged: (d) {
              playerBloc.add(TrackingCurrentPosition(d));
              playerBloc.add(InitStream(
                  'ac75ed9c-4f69-4c59-a4cc-8843c8a33108', d.inSeconds));
            },
            waveformStyle: WaveformStyle(
                isRoundedRectangle: true,
                borderWidth: 1,
                inactiveColor: Colors.grey,
                inactiveBorderColor: Colors.grey,
                activeColor: Colors.red,
                activeBorderColor: Colors.red),
          ),
        ],
      ),
    );
  }
}
