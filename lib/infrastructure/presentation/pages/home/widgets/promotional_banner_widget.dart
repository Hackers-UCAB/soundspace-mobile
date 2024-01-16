import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../../../../../domain/promotional_banner/promotional_banner.dart';

class PromotionalBannerWidget extends StatelessWidget {
  final PromotionalBanner banner;

  const PromotionalBannerWidget({super.key, required this.banner});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.memory(
          Uint8List.fromList(banner.image),
          width: size.width * 0.92,
          height: 200,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
