import 'package:flutter/material.dart';
import 'package:general_audio_waveforms/general_audio_waveforms.dart';
import 'package:get/get.dart';
import 'package:sign_in_bloc/application/BLoC/player/player_bloc.dart';

class MusicWavePlayer extends StatelessWidget {
  final PlayerBloc playerBloc;
  final PlayerState playerState;
  const MusicWavePlayer(
      {super.key, required this.playerBloc, required this.playerState});

  @override
  Widget build(BuildContext context) {
    final size = context.mediaQuery.size;
    return SizedBox(
    return SizedBox(
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
                waveformType: WaveformType.rectangle,
                height: 70,
                width: size.width * 0.7,
                source: AudioDataSource(samples: playerState.waveForm),
                maxDuration: playerState.duration,
                elapsedDuration:
                    playerState.duration > playerBloc.state.position
                        ? playerBloc.state.position
                        : playerState.duration,
                elapsedIsChanged: (d) {
                  if (playerState.isFinished) {
                    playerBloc.add(UpdateSeekPosition(d));
                    playerBloc.add(InitStream(
                        playerState.currentIdSong,
                        d.inSeconds,
                        playerState.currentNameSong,
                        playerState.duration));
                  }
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
                      onPressed: () {
                        if ((playerState.position.inSeconds - 10 > 0) &&
                            (playerState.isFinished)) {
                          playerBloc.add(InitStream(
                              playerState.currentIdSong,
                              playerState.position.inSeconds - 10,
                              playerState.currentNameSong,
                              playerState.duration));
                        }
                      },
                      icon: Icon(
                        Icons.replay_10_outlined,
                        color: ((playerState.position.inSeconds - 10 > 0) &&
                                (playerState.isFinished))
                            ? Colors.white
                            : Colors.grey,
                        size: 35,
                      )),
                  IconButton(
                      onPressed: () {
                        if ((playerState.position.inSeconds + 10 <
                                playerState.duration.inSeconds) &&
                            (playerState.isFinished)) {
                          playerBloc.add(InitStream(
                              playerState.currentIdSong,
                              playerState.position.inSeconds + 10,
                              playerState.currentNameSong,
                              playerState.duration));
                        }
                      },
                      icon: Icon(
                        Icons.replay_30_outlined,
                        color: ((playerState.position.inSeconds + 10 <
                                    playerState.duration.inSeconds) &&
                                (playerState.isFinished))
                            ? Colors.white
                            : Colors.grey,
                        size: 35,
                      )),
                  IconButton(
                      onPressed: () {
                        playerState.speed == 1.0
                            ? playerBloc.add(UpdateSpeed(1.5))
                            : playerBloc.add(UpdateSpeed(1.0));
                      },
                      icon: Icon(
                        playerState.speed == 1.0
                            ? Icons.one_k_outlined
                            : Icons.two_k_outlined,
                        color: Colors.white,
                        size: 35,
                      )),
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
