import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/playlist_detail/playlist_detail_bloc.dart';
import 'package:sign_in_bloc/application/use_cases/playlist/get_playlist_data_use_case.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/shared/custom_circular_progress_indicator.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/shared/error_page.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/shared/ipage.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/shared/image_cover.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/shared/info.dart';
import '../../../../application/BLoC/player/player_bloc.dart';
import '../../widgets/shared/music_wave_player.dart';
import '../../widgets/shared/tracklist.dart';

class PlaylistDetail extends IPage {
  final String playlistId;
  late final PlaylistDetailBloc playlistBloc;

  PlaylistDetail({super.key, required this.playlistId}) {
    playlistBloc = PlaylistDetailBloc(
        getPlaylistDataUseCase: GetIt.instance.get<GetPlaylistDataUseCase>());
  }

  @override
  Widget child(BuildContext context) {
    return BlocProvider(create: (context) {
      playlistBloc.add(FetchPlaylistDetailEvent(playlistId: playlistId));
      return playlistBloc;
    }, child: BlocBuilder<PlaylistDetailBloc, PlaylistDetailState>(
        builder: (contex, playlistState) {
      if (playlistState is PlaylistDetailLoaded) {
        return Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageCover(
                      image: playlistState.playlist.image,
                      height: 150,
                      width: 300,
                      bottomPadding: 5),
                  Info(
                    name: playlistState.playlist.name!,
                    artistName: playlistState.playlist.artistName,
                    songs: playlistState.playlist.songs!,
                    duration: playlistState.playlist.duration!,
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocBuilder<PlayerBloc, PlayerState>(
                          builder: (contex, state) {
                        return Visibility(
                            visible: state.isUsed,
                            child: MusicWavePlayer(
                                playerBloc: GetIt.instance.get<PlayerBloc>(),
                                playerState: state));
                      }),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Tracklist(songs: playlistState.playlist.songs!),
                  const SizedBox(height: 100),
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
    }));
  }

  @override
  Future<void> onRefresh() async {
    playlistBloc.add(FetchPlaylistDetailEvent(playlistId: playlistId));
  }
}
