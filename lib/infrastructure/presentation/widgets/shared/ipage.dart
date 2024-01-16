import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/player/player_bloc.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/bloc_listeners/log_out_listener.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/bloc_listeners/user_permissions_listener.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/shared/music_player.dart';
import '../../config/router/app_router.dart';
import 'custom_app_bar.dart';

abstract class IPage extends StatelessWidget {
  const IPage({super.key});

  Widget child(BuildContext context);

  Future<void> onRefresh();

  @override
  Widget build(BuildContext context) {
    final navigator = GetIt.instance.get<AppNavigator>();
    final playerBloc = GetIt.instance.get<PlayerBloc>();
    return Scaffold(
      body: Stack(children: [
        const GradientBackground(),
        RefreshIndicator(
            onRefresh: onRefresh,
            child: ListView(children: [
              Column(
                children: [
                  Column(
                    children: [
                      if (navigator.currentLocation != '/' &&
                          navigator.currentLocation != '/logIn')
                        const CustomAppBar(),
                      UserPermissionsListener(
                          child: LogOutListener(
                        child: child(context),
                      )),
                    ],
                  ),
                ],
              )
            ])),
        BlocBuilder<PlayerBloc, PlayerState>(builder: (context, state) {
          return Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Visibility(
              visible: state.isUsed,
              child: MusicPlayer(playerBloc: playerBloc, playerState: state),
            ),
          );
        })
      ]),
    );
  }
}

class GradientBackground extends StatelessWidget {
  const GradientBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: <Color>[
            Color.fromARGB(255, 52, 13, 131),
            Color.fromARGB(255, 30, 8, 58),
            Color.fromARGB(255, 24, 18, 31),
            Color.fromARGB(255, 30, 8, 58),
            Color.fromARGB(255, 57, 13, 145),
          ],
        ),
      ),
    );
  }
}
