import 'package:flutter/material.dart';
import '../../../../domain/album/album.dart';

class AlbumClipRRect extends StatelessWidget {
  final Album album;

  const AlbumClipRRect({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        album.imageURL,
        fit: BoxFit.fill,
        width: 180,
      ),
    );
  }
}
