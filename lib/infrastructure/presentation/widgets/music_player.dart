import 'package:flutter/material.dart';
import 'package:sign_in_bloc/application/BLoC/player/player_bloc.dart';

class MusicPlayer extends StatelessWidget {
  final PlayerBloc playerBloc;
  final PlayerState playerState;
  const MusicPlayer(
      {super.key, required this.playerBloc, required this.playerState});

  @override
  Widget build(BuildContext context) {
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

    if (((playerBloc.state.position.inSeconds.toDouble() /
                playerBloc.state.duration.inSeconds.toDouble()) *
            100.toDouble()) >
        99.5) {
      playerBloc.add(ResetPlayer());
    }

    return Container(
      height: 82, //TODO: Cuidado con esto y la onda comentada
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
            padding: const EdgeInsets.only(left: 10, right: 10, top: 8),
            child: Row(
              children: [
                playerState.isLoading
                    ? const CircularProgressIndicator()
                    : IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () {
                          playerBloc.add(PlayerPlaybackStateChanged(
                              !playerBloc.state.playbackState));
                        },
                        icon: Icon(
                          playerState.playbackState
                              ? Icons.pause_circle
                              : Icons.play_circle_fill,
                          size: 50,
                          color: const Color(0xff1de1ee),
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
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontSize: 12),
                      ),
                      const SizedBox(width: 6),
                      //IconButton(
                      //  padding: const EdgeInsets.all(0),
                      //  onPressed: () => {
                      //    playerBloc.add(
                      //      InitStream(
                      //          'ac75ed9c-4f69-4c59-a4cc-8843c8a33108', 15),
                      //    )
                      //  },
                      //  icon: const Icon(
                      //    Icons.play_arrow_sharp,
                      //    color: Color(0xff1de1ee),
                      //  ),
                      //),
                    ],
                  ),
                )
              ],
            ),
          ),
          // GeneralAudioWaveform(
          //   scalingAlgorithmType: ScalingAlgorithmType.median,
          //   waveformType: WaveformType.rectangle,
          //   height: 80,
          //   width: 400,
          //   maxSamples: GetIt.instance.get<PlayerBloc>().state.waveForm.length,
          //   source: AudioDataSource(
          //       samples: GetIt.instance.get<PlayerBloc>().state.waveForm),
          //   maxDuration: const Duration(minutes: 3, seconds: 13),
          //   elapsedDuration: playerBloc.state.position,
          //   elapsedIsChanged: (d) {
          //     playerBloc.add(UpdateSeekPosition(d));
          //     playerBloc.add(InitStream(
          //         'ac75ed9c-4f69-4c59-a4cc-8843c8a33108', d.inSeconds));
          //   },
          //   scrollable: true,
          //   waveformStyle: WaveformStyle(
          //       isRoundedRectangle: true,
          //       borderWidth: 1,
          //       inactiveColor: Colors.grey,
          //       inactiveBorderColor: Colors.grey,
          //       activeColor: Colors.red,
          //       activeBorderColor: Colors.red),
          // ),
        ],
      ),
    );
  }
}
