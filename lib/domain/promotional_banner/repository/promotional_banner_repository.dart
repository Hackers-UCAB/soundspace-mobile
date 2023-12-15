import '../promotional_banner.dart';
import '../../../common/result.dart';

abstract class PromotionalBannerRepository {
  Future<Result<PromotionalBanner>> getPromotionalBanner();
}
