import 'package:sign_in_bloc/infrastructure/services/api_connection_manager.dart';

import '../../../domain/promotional_banner/promotional_banner.dart';
import '../../../domain/promotional_banner/repository/promotional_banner_repository.dart';
import '../../mappers/promotionalBanner/promotional_banner_mapper.dart';
import '../../../commons/result.dart';

class PromotionalBannerRepositoryImpl extends PromotionalBannerRepository {
  final IApiConnectionManager apiconnectionManager;

  PromotionalBannerRepositoryImpl(
      {required this.apiconnectionManager}); //mejorar esto

  @override
  Future<Result<PromotionalBanner>> getPromotionalBanner() async {
    final result = await apiconnectionManager.request('publicidad', 'GET');
    if (result.hasValue()) {
      return Result(
          value: PromotionalBannerMapper.fromJson(result.value.data['data']),
          error: null);
    } else {
      return Result(value: null, error: Error());
    }
  }
}
