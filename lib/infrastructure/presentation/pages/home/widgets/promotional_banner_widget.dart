import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/infrastructure/presentation/config/router/app_router.dart';
import '../../../../../domain/promotional_banner/promotional_banner.dart';

class PromotionalBannerWidget extends StatelessWidget {
  final PromotionalBanner banner;

  const PromotionalBannerWidget({super.key, required this.banner});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: GestureDetector(
        onTap: () {
          GetIt.instance.get<AppNavigator>().navigateTo('/album/:${banner.id}');
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.memory(
            Uint8List.fromList(banner.image),
            width: size.width * 0.92,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
