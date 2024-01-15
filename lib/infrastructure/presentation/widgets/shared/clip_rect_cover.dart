import 'dart:typed_data';

import 'package:flutter/material.dart';

class ClipRRectCover extends StatelessWidget {
  final List<int>? image;
  final double width;
  final double height;

  const ClipRRectCover(
      {super.key,
      required this.image,
      required this.width,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        width: width,
        height: height,
        child: Image.memory(
          Uint8List.fromList(image!),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
