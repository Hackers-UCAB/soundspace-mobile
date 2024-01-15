import 'package:flutter/material.dart';
import 'clip_rect_cover.dart';

class ImageCover extends StatelessWidget {
  final List<int>? image;
  final double width;
  final double height;
  final double bottomPadding;

  const ImageCover(
      {super.key,
      required this.image,
      required this.width,
      required this.height,
      required this.bottomPadding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: SizedBox(
        width: double.infinity,
        height: 250,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRectCover(image: image, width: width, height: height),
          ],
        ),
      ),
    );
  }
}
