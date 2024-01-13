import 'package:flutter/material.dart';
import 'album_clip_rect.dart';

class AlbumImage extends StatelessWidget {
  final dynamic album;

  const AlbumImage({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
      child: SizedBox(
        width: double.infinity,
        height: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AlbumClipRRect(album: album),
          ],
        ),
      ),
    );
  }
}
