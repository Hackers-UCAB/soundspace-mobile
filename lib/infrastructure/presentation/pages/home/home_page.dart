import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/player/player_bloc.dart';
import 'package:sign_in_bloc/application/BLoC/trendings/trendings_bloc.dart';
import 'package:sign_in_bloc/infrastructure/presentation/pages/home/widgets/promotional_banner_widget.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/error_page.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/ipage.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/tracklist.dart';
import '../../widgets/albums_carousel.dart';
import 'widgets/artists_carousel.dart';
import 'widgets/playlist_wrap.dart';
import '../../widgets/music_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends IPage {
  const HomePage({super.key});

  @override
  Widget child(BuildContext context) {
    final trendingsBloc = GetIt.instance.get<TrendingsBloc>();
    trendingsBloc.add(FetchTrendingsEvent());
    return RefreshIndicator(
      onRefresh: () async {
        trendingsBloc.add(FetchTrendingsEvent());
      },
      child: ListView(children: [
        BlocBuilder<PlayerBloc, PlayerState>(
          builder: (context, playerState) {
            return BlocBuilder<TrendingsBloc, TrendingsState>(
              builder: (context, trendingsState) {
                if (trendingsState is TrendingsLoaded) {
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
                            ),
                            PromotionalBannerWidget(
                              banner: trendingsState.promotionalBanner,
                            ),
                            //TODO: Hacer el banner de suscripcion
                            _Collapse(name: 'Playlist', child: [
                              PlaylistWrap(
                                  playlists: trendingsState.trendingPlaylists)
                            ]),
                            _Collapse(name: 'Aqustico Experience', child: [
                              AlbumsCarousel(
                                  albums: trendingsState.trendingAlbums)
                            ]),
                            _Collapse(name: 'Artistas Trending', child: [
                              ArtistsCarousel(
                                  artists: trendingsState.trendingArtists)
                            ]),
                            const Divider(
                              color: Color.fromARGB(18, 142, 139, 139),
                              height: 40, //TODO: poner responsive
                              thickness: 2,
                              indent: 20,
                              endIndent: 20,
                            ),
                            _Collapse(name: 'Tracklist', child: [
                              Tracklist(songs: trendingsState.trendingSongs)
                            ]),
                            const SizedBox(height: 100)
                          ],
                        ),
                      ),
                      Visibility(
                        visible: playerState is PlayingState,
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: MusicPlayer(key: key),
                        ),
                      )
                    ],
                  );
                } else if (trendingsState is TrendingsLoading) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return ErrorPage(failure: trendingsState.failure!);
                }
              },
            );
          },
        ),
      ]),
    );
  }
}

class _Collapse extends StatelessWidget {
  final String name;
  final List<Widget> child;

  const _Collapse({required this.name, required this.child});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: Material(
        color: Colors.transparent,
        child: ExpansionTile(
          initiallyExpanded: true,
          title: Text(
            name,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          children: List.generate(child.length, (index) => child[index]),
        ),
      ),
    );
  }
}
