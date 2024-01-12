import 'package:flutter/material.dart';
import 'clip_rect_cover.dart';

class ImageCover extends StatelessWidget {
  final List<int>? image;

  const ImageCover({super.key, required this.image});

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
            ClipRRectCover(image: image),
          ],
        ),
      ),
    );
  }
}
