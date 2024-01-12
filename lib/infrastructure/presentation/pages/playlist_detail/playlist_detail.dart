import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/player/player_bloc.dart';
import 'package:sign_in_bloc/application/BLoC/playlist_detail/playlist_detail_bloc.dart';
import 'package:sign_in_bloc/application/use_cases/playlist/get_playlist_data_use_case.dart';
import 'package:sign_in_bloc/infrastructure/presentation/pages/album_detail/widgets/album_image.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/custom_circular_progress_indicator.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/error_page.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/ipage.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/shared/image_cover.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/shared/info.dart';

import 'widgets/Tracklist.dart';

class PlaylistDetail extends IPage {
  final String playlistId;
  late final PlaylistDetailBloc playlistBloc;

  PlaylistDetail({super.key, required this.playlistId}) {
    playlistBloc = PlaylistDetailBloc(
        getPlaylistDataUseCase: GetIt.instance.get<GetPlaylistDataUseCase>())
      ..add(FetchPlaylistDetailEvent(playlistId: playlistId));
  }

  @override
  Widget child(BuildContext context) {
    return BlocProvider(
      create: (context) => playlistBloc,
      child:
          BlocBuilder<PlayerBloc, PlayerState>(builder: (context, playerState) {
        return BlocBuilder<PlaylistDetailBloc, PlaylistDetailState>(
            builder: (contex, playlistState) {
          if (playlistState is PlaylistDetailLoaded) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ImageCover(image: playlistState.playlist.image),
                      Info(
                        name: playlistState.playlist.name,
                        artistName: playlistState.playlist.artistName,
                        songs: playlistState.playlist.songs,
                      ),
                      SizedBox(height: 20),
                      Tracklist(songs: playlistState.playlist.songs!),
                    ],
                  ),
                )
              ],
            );
          } else if (playlistState is PlaylistDetailFailed) {
            return ErrorPage(failure: playlistState.failure);
          } else {
            return const CustomCircularProgressIndicator();
          }
        });
      }),
    );
  }

  @override
  Future<void> onRefresh() async {
    playlistBloc.add(FetchPlaylistDetailEvent(playlistId: playlistId));
  }
}
