import 'package:flutter/material.dart';

import '../../../../../domain/promotional_banner/promotional_banner.dart';

class PromotionalBannerWidget extends StatefulWidget {
  final PromotionalBanner banner;

  const PromotionalBannerWidget({super.key, required this.banner});

  @override
  State<PromotionalBannerWidget> createState() =>
      _PromotionalBannerWidgetState();
}

class _PromotionalBannerWidgetState extends State<PromotionalBannerWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: GestureDetector(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            widget.banner.imgPath,
            width: size.width * 0.92,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
