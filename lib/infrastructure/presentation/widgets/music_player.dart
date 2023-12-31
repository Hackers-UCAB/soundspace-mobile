import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/player/player_bloc.dart';
import '../../../application/BLoC/socket/socket_bloc.dart';

class MusicPlayer extends StatelessWidget {
  const MusicPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final socketBloc = GetIt.instance.get<SocketBloc>();
    final playerBloc = GetIt.instance.get<PlayerBloc>();

    if (((playerBloc.state.position.inSeconds.toDouble() /
                playerBloc.state.duration.inSeconds.toDouble()) *
            100.toDouble()) ==
        100.0) {
      playerBloc.add(ResetPlayer());
    }

    return Container(
      height: 75,
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
                        '${playerBloc.state.position.inMinutes}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(width: 6),
                      IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () => {
                          //playerBloc.add(PlayingStartedEvent(song: song)),
                          socketBloc.add(
                            const SocketSendIdSong(
                                'de7ae1e9-3e38-4ce6-825b-b3045c8d5054'),
                          )
                          //socketBloc.add(const SocketSendIdSong(
                          //    '78c071d3-d1b3-49e1-9658-420eb89415fc'))
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
          //child: GeneralAudioWaveform(
          //  scalingAlgorithmType: ScalingAlgorithmType.average,
          //  waveformType: WaveformType.pulse,
          //  absolute: true,
          //  height: 80,
          //  width: 150,
          //  maxSamples: wave.length,
          //  source: AudioDataSource(samples: wave),
          //  maxDuration: Duration(minutes: 4),
          //  elapsedDuration: elapsedTime,
          //  elapsedIsChanged: (d) {},
          //  waveformStyle: WaveformStyle(
          //      borderWidth: 2,
          //      inactiveColor: Colors.white,
          //      activeColor: Colors.white),
          //),
        ],
      ),
    );
  }
}
