import 'package:sign_in_bloc/infrastructure/helpers/image_convertert.dart';

import '../../../domain/promotional_banner/promotional_banner.dart';

class PromotionalBannerMapper {
  static PromotionalBanner fromJson(Map<String, dynamic> json) {
    return PromotionalBanner(
        id: json['id'],
        pathRedirection: json['url'],
        image: ImageConverter.convert(json['image']['data']));
  }

  static Map<String, dynamic> toJson(PromotionalBanner promotionalBanner) {
    return {
      'id': promotionalBanner.id,
      'url': promotionalBanner.pathRedirection,
      'image': {'type': 'Buffer', 'data': promotionalBanner.image}
    };
  }
}
