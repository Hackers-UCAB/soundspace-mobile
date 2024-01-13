import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../../../domain/playlist/playlist.dart';
import '../../../config/router/app_router.dart';

class PlaylistWrap extends StatelessWidget {
  final List<Playlist> playlists;

  const PlaylistWrap({super.key, required this.playlists});

  @override
  Widget build(BuildContext context) {
    final List<_PlaylistCard> playlistCards = playlists
        .map((playlist) => _PlaylistCard(
              id: playlist.id,
              img: playlist.image!,
            ))
        .toList();

    final List<Wrap> wraps = [];
    for (var i = 0; i < playlistCards.length; i += 4) {
      int limit;
      ((i + 4) > playlistCards.length)
          ? limit = playlistCards.length
          : limit = i + 4;
      wraps.add(
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: playlistCards.sublist(i, limit),
        ),
      );
    }

    return SizedBox(
      height: 240,
      child: Padding(
        padding: const EdgeInsets.only(left: 14),
        child: PageView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: (playlistCards.length / 4).round(),
          itemBuilder: (context, index) => wraps[index],
        ),
      ),
    );
  }
}

class _PlaylistCard extends StatelessWidget {
  final String id;
  final List<int> img;

  const _PlaylistCard({required this.id, required this.img});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => {
        //TODO: Javier
        GetIt.instance.get<AppNavigator>().navigateTo('/playlist/$id'),
      },
      child: SizedBox(
          width: size.width * 0.45,
          height: size.width * 0.26,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.memory(
              Uint8List.fromList(img),
              fit: BoxFit.cover,
            ),
          )),
    );
  }
}
