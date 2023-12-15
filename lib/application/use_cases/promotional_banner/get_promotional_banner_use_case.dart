import '../../../domain/promotional_banner/promotional_banner.dart';
import '../../../domain/promotional_banner/repository/promotional_banner_repository.dart';
import '../../../common/result.dart';

class GetPromotionalBannerUseCase {
  final PromotionalBannerRepository promotionalBannerRepository;

  GetPromotionalBannerUseCase({required this.promotionalBannerRepository});

  Future<Result<PromotionalBanner>> execute() async {
    return await promotionalBannerRepository.getPromotionalBanner();
  }
}
