import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../../../domain/artist/artist.dart';
import '../../../config/router/app_router.dart';

class ArtistsCarousel extends StatelessWidget {
  final List<Artist> artists;
  const ArtistsCarousel({Key? key, required this.artists}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<_ArtistCard> artistCards = artists
        .map((artist) => _ArtistCard(
              artist: artist,
            ))
        .toList();

    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: SizedBox(
        height: 150,
        child: PageView.builder(
          controller: PageController(viewportFraction: 0.38, initialPage: 0),
          itemCount: artists.length,
          itemBuilder: (context, index) => artistCards[index],
          padEnds: false,
        ),
      ),
    );
  }
}

class _ArtistCard extends StatelessWidget {
  final Artist artist;
  const _ArtistCard({required this.artist});

  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.instance;
    final AppNavigator appNavigator = getIt.get<AppNavigator>();
    final size = MediaQuery.of(context).size;
    return Column(children: [
      GestureDetector(
        onTap: () {
          appNavigator.navigateTo('/artist');
        },
        child: Material(
          elevation: 5.0,
          color: Colors.transparent,
          shape: const CircleBorder(eccentricity: 1),
          child: SizedBox(
            width: size.width * 0.3,
            height: size.width * 0.3,
            child: ClipOval(
                child: Image.network(
              artist.imageURL,
              fit: BoxFit.cover,
            )),
          ),
        ),
      ),
      Text(artist.name)
    ]);
  }
}
