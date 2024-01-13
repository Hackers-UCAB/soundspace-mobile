import 'dart:typed_data';

import 'package:flutter/material.dart';

class ClipRRectCover extends StatelessWidget {
  final List<int>? image;

  const ClipRRectCover({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        width: 250,
        height: 250,
        child: Image.memory(
          Uint8List.fromList(image!),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
