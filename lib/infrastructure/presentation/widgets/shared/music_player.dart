import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_bloc/application/BLoC/player/player_bloc.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/shared/play_pause_icon.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/shared/replay_forward_icon.dart';

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
      height: size.width * 0.23, //TODO: Cuidado con esto
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 24, 15, 35),
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
              onSeek: (d) {},
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
                .copyWith(fontSize: size.width * 0.025),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ReplayForwardIcon(
                  playerBloc: playerBloc,
                  playerState: playerState,
                  replay: true,
                  scale: 0.065),
              PlayPauseIcon(
                  playerBloc: playerBloc,
                  playerState: playerState,
                  scale: 0.09),
              ReplayForwardIcon(
                  playerBloc: playerBloc,
                  playerState: playerState,
                  replay: false,
                  scale: 0.065),
            ],
          ),
        ],
      ),
    );
  }
}
