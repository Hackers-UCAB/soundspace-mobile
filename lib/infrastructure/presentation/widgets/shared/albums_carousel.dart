import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_gallery_3d/gallery3d.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/infrastructure/presentation/config/router/app_router.dart';
import '../../../../domain/album/album.dart';

class AlbumsCarousel extends StatefulWidget {
  final List<Album> albums;

  const AlbumsCarousel({super.key, required this.albums});

  @override
  State<AlbumsCarousel> createState() => _AlbumsCarouselState();
}

class _AlbumsCarouselState extends State<AlbumsCarousel> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<_AlbumCard> albumsCard =
        widget.albums.map((album) => _AlbumCard(album: album)).toList();

    if (albumsCard.length < 3) {
      return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: albumsCard
              .map<Widget>((card) => GestureDetector(
                    onTap: () => GetIt.instance
                        .get<AppNavigator>()
                        .navigateTo('/album/${card.album.id}'),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                          width: size.width * 0.4,
                          height: size.width * 0.4,
                          child: card),
                    ),
                  ))
              .toList());
    }

    return Gallery3D(
      controller:
          Gallery3DController(itemCount: albumsCard.length, autoLoop: false),
      width: size.width,
      height: 150,
      onClickItem: (index) => GetIt.instance
          .get<AppNavigator>()
          .navigateTo('/album/${widget.albums[index].id}'),
      onItemChanged: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      itemConfig: const GalleryItemConfig(
          width: 150,
          height: 150,
          radius: 10,
          shadows: [
            BoxShadow(
                color: Color.fromARGB(144, 23, 22, 22),
                offset: Offset(2, 0),
                blurRadius: 20.0)
          ]),
      itemBuilder: (context, index) => albumsCard[index],
    );
  }
}

class _AlbumCard extends StatelessWidget {
  final Album album;
  const _AlbumCard({required this.album});

  @override
  Widget build(BuildContext context) {
    return album.id == ''
        ? ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Image.asset(
              'images/c2.jpg',
              fit: BoxFit.cover,
            ))
        : ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Image.memory(
              Uint8List.fromList(album.image!),
              fit: BoxFit.cover,
            ));
  }
}
