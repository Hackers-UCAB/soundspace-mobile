import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/player/player_bloc.dart';
import 'package:sign_in_bloc/application/BLoC/trendings/trendings_bloc.dart';
import 'package:sign_in_bloc/infrastructure/presentation/pages/home/widgets/promotional_banner_widget.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/custom_circular_progress_indicator.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/error_page.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/ipage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/music_player.dart';

class HomePage extends IPage {
  final getIt = GetIt.instance;
  late final trendingsBloc = getIt.get<TrendingsBloc>();
  HomePage({super.key});

  @override
  Future<void> onRefresh() async {
    trendingsBloc.add(FetchTrendingsEvent());
  }

  @override
  Widget child(BuildContext context) {
    trendingsBloc.add(FetchTrendingsEvent());
    return BlocBuilder<TrendingsBloc, TrendingsState>(
      builder: (context, trendingsState) {
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
                    // _Collapse(name: 'Playlist', child: [
                    //   PlaylistWrap(
                    //       playlists: trendingsState.trendingPlaylists)
                    // ]),
                    // _Collapse(name: 'Aqustico Experience', child: [
                    //   AlbumsCarousel(
                    //       albums: trendingsState.trendingAlbums)
                    // ]),
                    // _Collapse(name: 'Artistas Trending', child: [
                    //   ArtistsCarousel(
                    //       artists: trendingsState.trendingArtists)
                    // ]),
                    // const Divider(
                    //   color: Color.fromARGB(18, 142, 139, 139),
                    //   height: 40, //TODO: poner responsive
                    //   thickness: 2,
                    //   indent: 20,
                    //   endIndent: 20,
                    // ),
                    // _Collapse(name: 'Tracklist', child: [
                    //   Tracklist(songs: trendingsState.trendingSongs)
                    // ]),
                    // const SizedBox(height: 100)
                  ],
                ),
              ),
              IconButton(
                padding: const EdgeInsets.all(0),
                onPressed: () => {
                  GetIt.instance.get<PlayerBloc>().add(
                        InitStream('ac75ed9c-4f69-4c59-a4cc-8843c8a33108', 0),
                      )
                },
                icon: const Icon(
                  Icons.play_arrow_sharp,
                  color: Color(0xff1de1ee),
                ),
              ),
              //Visibility(
              //  visible: GetIt.instance.get<PlayerBloc>().state.isUsed,
              //  child: Align(
              //    alignment: Alignment.bottomLeft,
              //    child: Column(
              //      children: [MusicPlayer(key: key)],
              //    ),
              //  ),
              //)
            ],
          );
        } else if (trendingsState is TrendingsLoading) {
          return const CustomCircularProgressIndicator();
        } else {
          return ErrorPage(failure: trendingsState.failure!);
        }
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
            style: Theme.of(context).textTheme.bodySmall,
          ),
          children: List.generate(child.length, (index) => child[index]),
        ),
      ),
    );
  }
}
