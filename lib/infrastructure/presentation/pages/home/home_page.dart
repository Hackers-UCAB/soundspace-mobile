import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/player/player_bloc.dart';
import 'package:sign_in_bloc/application/BLoC/trendings/trendings_bloc.dart';
import 'package:sign_in_bloc/application/use_cases/album/get_trending_albums_use_case.dart';
import 'package:sign_in_bloc/application/use_cases/artist/get_trending_artists_use_case.dart';
import 'package:sign_in_bloc/infrastructure/presentation/pages/home/widgets/artists_carousel.dart';
import 'package:sign_in_bloc/infrastructure/presentation/pages/home/widgets/promotional_banner_widget.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/custom_circular_progress_indicator.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/error_page.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/ipage.dart';

import '../../../../application/use_cases/playlist/get_trending_playlists_use_case.dart';
import '../../../../application/use_cases/promotional_banner/get_promotional_banner_use_case.dart';
import '../../../../application/use_cases/song/get_trending_songs_use_case.dart';
import '../../widgets/albums_carousel.dart';
import '../../widgets/tracklist.dart';
import 'widgets/playlist_wrap.dart';

class HomePage extends IPage {
  final getIt = GetIt.instance;
  late final TrendingsBloc trendingsBloc;
  late final PlayerBloc playerBloc;

  HomePage({super.key}) {
    trendingsBloc = TrendingsBloc(
        getTrendingArtistsUseCase: getIt.get<GetTrendingArtistsUseCase>(),
        getTrendingAlbumsUseCase: getIt.get<GetTrendingAlbumsUseCase>(),
        getPromotionalBannerUseCase: getIt.get<GetPromotionalBannerUseCase>(),
        getTrendingPlaylistsUseCase: getIt.get<GetTrendingPlaylistsUseCase>(),
        getTrendingSongsUseCase: getIt.get<GetTrendingSongsUseCase>());

  }

  @override
  Future<void> onRefresh() async {
    trendingsBloc.add(FetchTrendingsEvent());

  }

  @override
  Widget child(BuildContext context) {
    return BlocProvider(
      create: (context) {
        trendingsBloc.add(FetchTrendingsEvent());
        return trendingsBloc;
      },
      child: BlocBuilder<TrendingsBloc, TrendingsState>(
        builder: (context, trendingsState) {
          trendingsBloc.state;
          if (trendingsState is TrendingsLoaded) {
            return Column(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      PromotionalBannerWidget(
                        banner: trendingsState.promotionalBanner,
                      ),
                      //TODO: Hacer el banner de suscripcion
                      _Collapse(name: 'Playlist', child: [
                        PlaylistWrap(
                            playlists: trendingsState.trendingPlaylists)
                      ]),
                      _Collapse(name: 'Aqustico Experience', child: [
                        AlbumsCarousel(albums: trendingsState.trendingAlbums)
                      ]),
                      _Collapse(name: 'Artistas Trending', child: [
                        ArtistsCarousel(artists: trendingsState.trendingArtists)
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
              ],
            );
          } else if (trendingsState is TrendingsLoading) {
            return const CustomCircularProgressIndicator();
          } else {
            return ErrorPage(failure: trendingsState.failure!);
          }
        },
      ),
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
