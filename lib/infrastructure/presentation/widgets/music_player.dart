import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
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

    if (playerState.position.inSeconds == playerState.duration.inSeconds) {
      playerBloc.add(ResetPlayer());
    }

    final size = MediaQuery.of(context).size;
    final bodySmall = Theme.of(context).textTheme.bodySmall;

    return Container(
      height: 102, //TODO: Cuidado con esto y la onda comentada
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 24, 15, 35),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          SizedBox(
            height: size.width * 0.02,
          ),
          SizedBox(
            width: size.width * 0.9,
            child: ProgressBar(
              progress: playerState.position,
              total: playerState.duration,
              buffered: playerState.bufferedDuration,
              bufferedBarColor: const Color.fromARGB(255, 68, 66, 66),
              barHeight: 5,
              baseBarColor: Colors.black,
              thumbCanPaintOutsideBar: false,
              thumbRadius: 0,
              timeLabelLocation: TimeLabelLocation.none,
              onSeek: (d) {
                if (playerState.isFinished) {
                  playerBloc.add(UpdateSeekPosition(d));
                  playerBloc.add(InitStream(
                      playerState.currentIdSong,
                      d.inSeconds,
                      playerState.currentNameSong,
                      playerState.duration));
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.width * 0.01),
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                playerState.currentNameSong,
                style: bodySmall!.copyWith(fontSize: size.width * 0.04),
              ),
            ),
          ),
          Text(
            '$addMinuteZero${playerBloc.state.position.inMinutes}:$addSecondZero${playerBloc.state.position.inSeconds % 60}',
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: size.width * 0.03),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  padding: const EdgeInsets.all(0),
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
                  icon: Image.asset(
                    'images/replay-10.png',
                    width: size.width * 0.065,
                  )),
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
                        size: size.width * 0.09,
                        color: Colors.white,
                      ),
                    ),
              IconButton(
                  padding: const EdgeInsets.all(0),
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
                  icon: Image.asset(
                    'images/forward-10.png',
                    width: size.width * 0.065,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
