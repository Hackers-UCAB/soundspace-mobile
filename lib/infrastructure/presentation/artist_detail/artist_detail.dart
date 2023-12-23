import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/artist_detail/artist_detail_bloc.dart';
import 'package:sign_in_bloc/domain/artist/artist.dart';
import 'package:sign_in_bloc/infrastructure/presentation/artist_detail/widgets/artist_info.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/albums_carousel.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/ipage.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/tracklist.dart';

class ArtistDetail extends IPage {
  final Artist artist;

  const ArtistDetail({super.key, required this.artist});

  @override
  Widget child(BuildContext context) {
    final artistBloc = GetIt.instance.get<ArtistDetailBloc>();
    artistBloc.add(FetchArtistDetailEvent(artist: artist));
    return RefreshIndicator(
        onRefresh: () async {
          artistBloc.add(FetchArtistDetailEvent(artist: artist));
        },
        child: ListView(
          children: [
            BlocBuilder<ArtistDetailBloc, ArtistDetailState>(
              builder: (context, artistState) {
                if (artistState is ArtistDetailLoaded) {
                  return Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            AppBar(
                              backgroundColor: Colors.transparent,
                              actions: const [
                                Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.more_vert,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 10),
                              ],
                            ), // TODO implementar ArtistInfo
                            ArtistInfo(artist: artistState.artistData),
                            AlbumsCarousel(albums: artistState.artistAlbums),
                            Tracklist(songs: artistState.artistSongs),
                            const Divider(
                              color: Color.fromARGB(18, 142, 139, 139),
                              height: 40, //TODO: poner responsive
                              thickness: 2,
                              indent: 20,
                              endIndent: 20,
                            ),
                            const SizedBox(height: 100)
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              },
            )
          ],
        ));
  }
}
