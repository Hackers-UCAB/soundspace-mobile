import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../../application/BLoC/player/player_bloc.dart';
import '../../config/router/app_router.dart';
import '../../widgets/ipage.dart';
import '../../widgets/music_player.dart';

class AlbumDetail extends IPage {
  final String albumId;

  const AlbumDetail({super.key, required this.albumId});

  @override
  Widget child(BuildContext context) {
    final getIt = GetIt.instance;
    final PlayerBloc playerBloc = getIt.get<PlayerBloc>();
    final AppNavigator appNavigator = getIt.get<AppNavigator>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => playerBloc,
        ),
      ],
      child: BlocBuilder<PlayerBloc, PlayerState>(
        builder: (context, playerState) {
          return Column(
            children: [
              const Text('Album Detail'),
              Visibility(
                visible: playerState is PlayingState,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: MusicPlayer(key: key),
                ),
              ),
              IconButton(
                  onPressed: () => appNavigator.pop(),
                  icon: const Icon(Icons.arrow_back))
            ],
          );
        },
      ),
    );
  }
}
