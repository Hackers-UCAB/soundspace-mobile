import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/player/player_bloc.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/custom_circular_progress_indicator.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/error_page.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/ipage.dart';
import '../../../../application/BLoC/album_detail/album_detail_bloc.dart';
import '../../widgets/tracklist.dart';
import 'widgets/album_image.dart';
import 'widgets/album_info.dart';

class AlbumDetail extends IPage {
  final String albumId;
  late final albumBloc = GetIt.instance.get<AlbumDetailBloc>();

  AlbumDetail({super.key, required this.albumId});

  @override
  Future<void> onRefresh() async {
    albumBloc.add(FetchAlbumDetailEvent(albumId: albumId));
  }

  @override
  Widget child(BuildContext context) {
    albumBloc.add(FetchAlbumDetailEvent(albumId: albumId));
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (context, playerState) {
        return BlocBuilder<AlbumDetailBloc, AlbumDetailState>(
          builder: (context, albumState) {
            if (albumState is AlbumDetailLoaded) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        AlbumImage(album: albumState.album),
                        AlbumInfo(album: albumState.album),
                        //TODO: Player ()
                        SizedBox(height: 20),
                        Tracklist(songs: albumState.album.songs!),
                      ],
                    ),
                  ),
                ],
              );
            } else if (albumState is AlbumDetailFailed) {
              return ErrorPage(failure: albumState.failure);
            } else {
              return const CustomCircularProgressIndicator();
            }
          },
        );
      },
    );
  }
}
