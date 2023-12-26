import '../../../common/use_case.dart';
import '../../../domain/promotional_banner/promotional_banner.dart';
import '../../../domain/promotional_banner/repository/promotional_banner_repository.dart';
import '../../../common/result.dart';

class GetPromotionalBannerUseCaseInput extends IUseCaseInput {}

class GetPromotionalBannerUseCase
    extends IUseCase<GetPromotionalBannerUseCaseInput, PromotionalBanner> {
  final PromotionalBannerRepository promotionalBannerRepository;

  GetPromotionalBannerUseCase({required this.promotionalBannerRepository});

  @override
  Future<Result<PromotionalBanner>> execute(
      GetPromotionalBannerUseCaseInput params) async {
    return await promotionalBannerRepository.getPromotionalBanner();
  }
}
