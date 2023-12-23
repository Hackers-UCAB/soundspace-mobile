import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/domain/artist/artist.dart';
import 'package:sign_in_bloc/domain/album/album.dart';
import '../../../application/BLoC/album_detail/album_detail_bloc.dart';
import '../widgets/tracklist.dart';
import 'widgets/album_header.dart';
import 'widgets/album_image.dart';
import 'widgets/album_info.dart';

class AlbumDetail extends StatelessWidget {
  final Artist artist;
  final Album album;

  const AlbumDetail({super.key, required this.artist, required this.album});

  @override
  Widget build(BuildContext context) {
    final albumBloc = GetIt.instance.get<AlbumDetailBloc>();
    albumBloc.add(FetchAlbumDetailEvent(album: album));
    return RefreshIndicator(
      onRefresh: () async {
        albumBloc.add(FetchAlbumDetailEvent(album: album));
      },
      child: ListView(
        children: [
          BlocBuilder<AlbumDetailBloc, AlbumDetailState>(
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
                          // Player ()
                          Tracklist(songs: albumState.songsByAlbum),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
