import 'package:sign_in_bloc/infrastructure/datasources/api/api_connection_manager.dart';

import '../../../domain/promotional_banner/promotional_banner.dart';
import '../../../domain/promotional_banner/repository/promotional_banner_repository.dart';
import '../../mappers/promotionalBanner/promotional_banner_mapper.dart';
import '../../../common/result.dart';

class PromotionalBannerRepositoryImpl extends PromotionalBannerRepository {
  final IApiConnectionManager apiconnectionManager;

  PromotionalBannerRepositoryImpl(
      {required this.apiconnectionManager}); //mejorar esto

  @override
  Future<Result<PromotionalBanner>> getPromotionalBanner() async {
    return await apiconnectionManager.request(
      'promotion',
      'GET',
      (data) => PromotionalBannerMapper.fromJson(data),
    );
  }
}
