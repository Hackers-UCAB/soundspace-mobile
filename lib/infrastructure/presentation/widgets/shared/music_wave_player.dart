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
      height: 80,
      width: size.width * 0.90,
      child: GeneralAudioWaveform(
        scalingAlgorithmType: ScalingAlgorithmType.median,
        waveformType: WaveformType.rectangle,
        height: 80,
        width: size.width * 0.90,
        maxSamples: playerState.waveForm.length,
        source: AudioDataSource(samples: playerState.waveForm),
        maxDuration: playerState.duration,
        elapsedDuration: playerBloc.state.position,
        elapsedIsChanged: (d) {
          playerBloc.add(UpdateSeekPosition(d));
          playerBloc.add(InitStream(playerState.currentIdSong, d.inSeconds,
              playerState.currentNameSong, playerState.duration));
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
    );
  }
}
