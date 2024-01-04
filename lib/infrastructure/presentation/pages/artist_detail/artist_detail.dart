import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/artist_detail/artist_detail_bloc.dart';
import 'package:sign_in_bloc/application/BLoC/player/player_bloc.dart';
import 'package:sign_in_bloc/infrastructure/presentation/pages/artist_detail/widgets/artist_info.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/albums_carousel.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/custom_circular_progress_indicator.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/ipage.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/tracklist.dart';
import '../../widgets/error_page.dart';
import '../search/widgets/custom_app_bar.dart';

class ArtistDetail extends IPage {
  final String artistId;
  late final artistBloc = GetIt.instance.get<ArtistDetailBloc>();

  ArtistDetail({super.key, required this.artistId});

  @override
  Future<void> onRefresh() async {
    artistBloc.add(FetchArtistDetailEvent(artistId: artistId));
  }

  @override
  Widget child(BuildContext context) {
    artistBloc.add(FetchArtistDetailEvent(artistId: artistId));
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (context, playerState) {
        return BlocBuilder<ArtistDetailBloc, ArtistDetailState>(
          builder: (context, artistState) {
            if (artistState is ArtistDetailLoading) {
              return const CustomCircularProgressIndicator();
            } else if (artistState is ArtistDetailLoaded) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        const CustomAppBar(),
                        // TODO: implementar ArtistInfo
                        ArtistInfo(artist: artistState.artist),
                        AlbumsCarousel(albums: artistState.artist.albums!),
                        Tracklist(songs: artistState.artist.songs!),
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
              return ErrorPage(failure: artistState.failure!);
            }
          },
        );
      },
    );
  }
}