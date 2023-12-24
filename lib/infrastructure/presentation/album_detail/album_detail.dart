import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/player/player_bloc.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/custom_circular_progress_indicator.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/error_page.dart';
import '../../../application/BLoC/album_detail/album_detail_bloc.dart';
import '../widgets/tracklist.dart';
import 'widgets/album_header.dart';
import 'widgets/album_image.dart';
import 'widgets/album_info.dart';

class AlbumDetail extends StatelessWidget {
  final String albumId;

  const AlbumDetail({super.key, required this.albumId});

  @override
  Widget build(BuildContext context) {
    final albumBloc = GetIt.instance.get<AlbumDetailBloc>();
    albumBloc.add(FetchAlbumDetailEvent(albumId: albumId));
    return RefreshIndicator(
      onRefresh: () async {
        albumBloc.add(FetchAlbumDetailEvent(albumId: albumId));
      },
      child: ListView(
        children: [
          BlocBuilder<PlayerBloc, PlayerState>(
            builder: (context, playerState) {
              return BlocBuilder<AlbumDetailBloc, AlbumDetailState>(
                builder: (context, albumState) {
                  if (albumState is AlbumDetailLoaded) {
                    return Stack(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              AlbumHeader(
                                onBackPress: () {
                                  Navigator.pop(context);
                                },
                              ),
                              AlbumImage(album: albumState.albumData),
                              AlbumInfo(album: albumState.albumData),
                              //TODO: Player ()
                              Tracklist(songs: albumState.songsByAlbum),
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
          )
        ],
      ),
    );
  }
}
