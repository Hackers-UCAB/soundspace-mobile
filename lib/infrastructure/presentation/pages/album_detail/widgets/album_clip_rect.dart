import 'dart:typed_data';

import 'package:flutter/material.dart';
import '../../../../../domain/album/album.dart';

class AlbumClipRRect extends StatelessWidget {
  final dynamic album;

  const AlbumClipRRect({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.memory(
        Uint8List.fromList(album.image!),
        fit: BoxFit.fill,
        width: 180,
      ),
    );
  }
}
