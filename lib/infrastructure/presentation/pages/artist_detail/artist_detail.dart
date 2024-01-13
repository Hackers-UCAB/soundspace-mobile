import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/artist_detail/artist_detail_bloc.dart';
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
        getArtistDataUseCase: GetIt.instance.get<GetArtistDataUseCase>());
  }

  @override
  Future<void> onRefresh() async {
    artistBloc.add(FetchArtistDetailEvent(artistId: artistId));
  }

  @override
  Widget child(BuildContext context) {
    return BlocProvider(create: (context) {
      artistBloc.add(FetchArtistDetailEvent(artistId: artistId));
      return artistBloc;
    }, child: BlocBuilder<ArtistDetailBloc, ArtistDetailState>(
      builder: (context, artistState) {
        if (artistState is ArtistDetailLoading) {
          return const CustomCircularProgressIndicator();
        } else if (artistState is ArtistDetailLoaded) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    ArtistInfo(artist: artistState.artist),
                    const SizedBox(
                      height: 10,
                    ),
                    if (artistState.artist.albums!.isNotEmpty)
                      AlbumsCarousel(albums: artistState.artist.albums!),
                    const SizedBox(
                      height: 60,
                    ),
                    Tracklist(songs: artistState.artist.songs!),
                    const SizedBox(
                      height: 100,
                    )
                  ],
                ),
              ),
            ],
          );
        } else {
          return ErrorPage(failure: artistState.failure!);
        }
      },
    ));
  }
}
