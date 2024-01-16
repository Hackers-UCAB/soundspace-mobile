import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/player/player_bloc.dart';
import 'package:sign_in_bloc/application/BLoC/user_permissions/user_permissions_bloc.dart';

class ReplayForwardIcon extends StatelessWidget {
  final PlayerBloc playerBloc;
  final PlayerState playerState;
  final bool replay;
  final double scale;

  const ReplayForwardIcon(
      {super.key,
      required this.playerBloc,
      required this.playerState,
      required this.replay,
      required this.scale});

  bool _condition(int seconds) {
    final userPermissionsBloc = GetIt.instance.get<UserPermissionsBloc>();

    if (replay) {
      return ((playerState.position.inSeconds - 10 > 0) &&
          (playerState.isFinished) &&
          userPermissionsBloc.state.isSubscribed);
    } else {
      return ((playerState.position.inSeconds + 10 <
              playerState.duration.inSeconds) &&
          (playerState.isFinished) &&
          userPermissionsBloc.state.isSubscribed);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final int seconds = replay ? -10 : 10;

    return IconButton(
        padding: const EdgeInsets.all(0),
        onPressed: () {
          if (_condition(seconds)) {
            playerBloc.add(InitStream(
                playerState.currentIdSong,
                playerState.position.inSeconds + seconds,
                playerState.currentNameSong,
                playerState.duration));
          }
        },
        icon: Image.asset(
          replay ? 'images/replay-10.png' : 'images/forward-10.png',
          width: size.width * scale,
          color: _condition(seconds) ? Colors.white : Colors.grey,
        ));
  }
}
