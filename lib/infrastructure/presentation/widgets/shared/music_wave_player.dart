import 'package:flutter/material.dart';
import 'package:general_audio_waveforms/general_audio_waveforms.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/player/player_bloc.dart';

class MusicWavePlayer extends StatelessWidget {
  final PlayerBloc playerBloc;
  final PlayerState playerState;
  const MusicWavePlayer(
      {super.key, required this.playerBloc, required this.playerState});

  @override
  Widget build(BuildContext context) {
    final size = context.mediaQuery.size;
    return Container(
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                        ? Icons.pause_circle_outline_outlined
                        : Icons.play_circle_outline_outlined,
                    size: 90,
                    color: Colors.white,
                  ),
                ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GeneralAudioWaveform(
                scalingAlgorithmType: ScalingAlgorithmType.median,
                waveformType: WaveformType.rectangle,
                height: 50,
                width: size.width * 0.7,
                maxSamples: playerState.waveForm.length,
                source: AudioDataSource(samples: playerState.waveForm),
                maxDuration: playerState.duration,
                elapsedDuration: playerBloc.state.position,
                elapsedIsChanged: (d) {
                  playerBloc.add(UpdateSeekPosition(d));
                  playerBloc.add(InitStream(
                      playerState.currentIdSong,
                      d.inSeconds,
                      playerState.currentNameSong,
                      playerState.duration));
                },
                scrollable: true,
                waveformStyle: WaveformStyle(
                    isRoundedRectangle: true,
                    borderWidth: 1,
                    inactiveColor: Colors.grey,
                    inactiveBorderColor: Colors.grey,
                    activeColor: Colors.red,
                    activeBorderColor: Colors.red),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.replay_10_outlined,
                        color: Colors.white,
                        size: 35,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.replay_30_outlined,
                        color: Colors.white,
                        size: 35,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.one_x_mobiledata_outlined,
                        color: Colors.white,
                        size: 35,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.volume_up_outlined,
                        color: Colors.white,
                        size: 35,
                      ))
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
