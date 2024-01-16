import 'package:flutter/material.dart';
import '../../../../application/BLoC/player/player_bloc.dart';

class PlayPauseIcon extends StatelessWidget {
  final PlayerBloc playerBloc;
  final PlayerState playerState;
  final double scale;

  const PlayPauseIcon({
    super.key,
    required this.playerBloc,
    required this.playerState,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (playerState.isLoading) {
      return const CircularProgressIndicator();
    } else {
      return IconButton(
        padding: const EdgeInsets.all(0),
        onPressed: () {
          if (playerState.isConnected) {
            playerBloc.add(
                PlayerPlaybackStateChanged(!playerBloc.state.playbackState));
          }
        },
        icon: Icon(
          playerState.playbackState
              ? Icons.pause_circle_outline_outlined
              : Icons.play_circle_outline_outlined,
          size: size.width * scale,
          color: Colors.white,
        ),
      );
    }
  }
}
