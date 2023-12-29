import '../../../domain/promotional_banner/promotional_banner.dart';

class PromotionalBannerMapper {
  static PromotionalBanner fromJson(Map<String, dynamic> json) {
    List<int> intList =
        json['image']['data'].map<int>((e) => e as int).toList();

    return PromotionalBanner(
        id: json['id'], pathRedirection: json['url'], image: intList);
  }

  static Map<String, dynamic> toJson(PromotionalBanner promotionalBanner) {
    return {
      'id': promotionalBanner.id,
      'url': promotionalBanner.pathRedirection,
      'image': {'type': 'Buffer', 'data': promotionalBanner.image}
    };
  }
}
