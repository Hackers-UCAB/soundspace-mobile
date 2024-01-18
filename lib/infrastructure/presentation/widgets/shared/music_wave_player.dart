import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sign_in_bloc/application/BLoC/player/player_bloc.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/shared/play_pause_icon.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/shared/replay_forward_icon.dart';
import 'package:flutter_audio_waveforms/flutter_audio_waveforms.dart';

class MusicWavePlayer extends StatelessWidget {
  final PlayerBloc playerBloc;
  final PlayerState playerState;
  const MusicWavePlayer(
      {super.key, required this.playerBloc, required this.playerState});

  @override
  Widget build(BuildContext context) {
    final size = context.mediaQuery.size;
    final speedImage = playerState.speed == 1.0
        ? 'images/speed-x1.png'
        : 'images/speed-x2.png';

    return SizedBox(
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          PlayPauseIcon(
              playerBloc: playerBloc, playerState: playerState, scale: 0.24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RectangleWaveform(
                samples: playerState.waveForm,
                height: 70,
                width: size.width * 0.7,
                elapsedDuration: playerState.position,
                maxDuration: playerState.duration,
                inactiveColor: Colors.grey,
                activeColor: Color.fromARGB(255, 57, 13, 145),
                activeBorderColor: Color.fromARGB(255, 57, 13, 145),
                isCentered: true,
                borderWidth: 0,
                inactiveBorderColor: Colors.grey,
                isRoundedRectangle: true,
              ),
              //GeneralAudioWaveform(
              //  waveformType: WaveformType.rectangle,
              //  height: 70,
              //  width: size.width * 0.7,
              //  source: AudioDataSource(samples: playerState.waveForm),
              //  maxDuration: playerState.duration,
              //  elapsedDuration:
              //      playerState.duration > playerBloc.state.position
              //          ? playerBloc.state.position
              //          : playerState.duration,
              //  elapsedIsChanged: (d) {},
              //  scrollable: false,
              //  waveformStyle: WaveformStyle(
              //      isRoundedRectangle: true,
              //      borderWidth: 1,
              //      inactiveColor: Colors.grey,
              //      inactiveBorderColor: Colors.grey,
              //      activeColor: Colors.red,
              //      activeBorderColor: Colors.red),
              //),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ReplayForwardIcon(
                      playerBloc: playerBloc,
                      playerState: playerState,
                      replay: true,
                      scale: 0.08),
                  ReplayForwardIcon(
                      playerBloc: playerBloc,
                      playerState: playerState,
                      replay: false,
                      scale: 0.08),
                  IconButton(
                    onPressed: () {
                      playerState.speed == 1.0
                          ? playerBloc.add(UpdateSpeed(1.5))
                          : playerBloc.add(UpdateSpeed(1.0));
                    },
                    icon: Image.asset(speedImage,
                        width: size.width * 0.08,
                        color: ((playerState.position.inSeconds +
                                        10 < //TODO: Revisar esto
                                    playerState.duration.inSeconds) &&
                                (playerState.isFinished))
                            ? Colors.white
                            : Colors.grey),
                  ),
                  IconButton(
                      onPressed: () {
                        playerState.volume == 1.0
                            ? playerBloc.add(UpdateVolume(0.0))
                            : playerBloc.add(UpdateVolume(1.0));
                      },
                      icon: Icon(
                        playerState.volume == 1.0
                            ? Icons.volume_up_outlined
                            : Icons.volume_mute_outlined,
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
