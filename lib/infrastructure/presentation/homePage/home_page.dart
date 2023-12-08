import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/player/player_bloc.dart';
import 'package:sign_in_bloc/application/BLoC/trendings/trendings_bloc.dart';
import 'package:sign_in_bloc/infrastructure/presentation/homePage/widgets/promotional_banner_widget.dart';
import 'package:sign_in_bloc/infrastructure/presentation/shared_widgets/ipage.dart';
import 'package:sign_in_bloc/infrastructure/presentation/shared_widgets/tracklist.dart';
import '../shared_widgets/albums_carousel.dart';
import 'widgets/artists_carousel.dart';
import 'widgets/playlist_wrap.dart';
import '../shared_widgets/music_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends IPage {
  const HomePage({super.key});

  @override
  Widget child(BuildContext context) {
    final trendingsBloc = GetIt.instance.get<TrendingsBloc>();
    trendingsBloc.add(FetchTrendingsEvent());
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (context, playerState) {
        return BlocBuilder<TrendingsBloc, TrendingsState>(
          builder: (context, trendingsState) {
            if (trendingsState is TrendingsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (trendingsState is TrendingsLoaded) {
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
                        _Collapse(name: 'Playlist', child: [
                          PlaylistWrap(
                              playlists: trendingsState.trendingPlaylists)
                        ]),
                        _Collapse(name: 'Aqustico Experience', child: [
                          AlbumsCarousel(albums: trendingsState.trendingAlbums)
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
            } else {
              return const Placeholder(); //Pantalla de error
            }
          },
        );
      },
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
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          children: List.generate(child.length, (index) => child[index]),
        ),
      ),
    );
  }
}
