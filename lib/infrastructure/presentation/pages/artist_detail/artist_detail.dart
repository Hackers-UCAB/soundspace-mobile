import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/artist_detail/artist_detail_bloc.dart';
import 'package:sign_in_bloc/application/BLoC/player/player_bloc.dart';
import 'package:sign_in_bloc/domain/album/album.dart';
import 'package:sign_in_bloc/infrastructure/presentation/pages/artist_detail/widgets/artist_info.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/albums_carousel.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/custom_circular_progress_indicator.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/ipage.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/tracklist.dart';
import '../../../../application/use_cases/artist/get_artist_data_use_case.dart';
import '../../widgets/error_page.dart';

class ArtistDetail extends IPage {
  final String artistId;
  late final ArtistDetailBloc artistBloc;

  ArtistDetail({super.key, required this.artistId}) {
    artistBloc = ArtistDetailBloc(
        getArtistDataUseCase: GetIt.instance.get<GetArtistDataUseCase>())
      ..add(FetchArtistDetailEvent(artistId: artistId));
  }

  @override
  Future<void> onRefresh() async {
    artistBloc.add(FetchArtistDetailEvent(artistId: artistId));
  }

  @override
  Widget child(BuildContext context) {
    return BlocProvider(
      create: (context) => artistBloc,
      child: BlocBuilder<PlayerBloc, PlayerState>(
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
                          SizedBox(
                            height: 20,
                          ),
                          ArtistInfo(artist: artistState.artist),
                          SizedBox(
                            height: 60,
                          ),
                          AlbumsCarousel(albums: artistState.artist.albums!),
                          SizedBox(
                            height: 60,
                          ),
                          Tracklist(songs: artistState.artist.songs!),
                          const Divider(
                            color: Color.fromARGB(18, 142, 139, 139),
                            height: 40, //TODO: poner responsive
                            thickness: 2,
                            indent: 20,
                            endIndent: 20,
                          ),
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
      ),
    );
  }
}
