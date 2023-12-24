import 'package:sign_in_bloc/commons/result.dart';
import 'package:sign_in_bloc/domain/artist/repository/artist_repository.dart';
import 'package:sign_in_bloc/infrastructure/mappers/artist/artist_mapper.dart';
import 'package:sign_in_bloc/infrastructure/services/api_connection_manager.dart';

import '../../../domain/artist/artist.dart';

class ArtistSearchRepositoryImpl extends ArtistRepository {
  final IApiConnectionManager _apiConnectionManager;

  ArtistSearchRepositoryImpl({required IApiConnectionManager apiConnectionManager})
      : _apiConnectionManager = apiConnectionManager;
  //mejorar esto

  @override
  Future<Result<List<Artist>>> getTrendingArtists() {
    // TODO: implement getArtistsByName
    throw UnimplementedError();
  }
  
  @override
  Future<Result<List<Artist>>> getArtistsByName(String name) async {
    final result =
        await _apiConnectionManager.request('artists/search_artists', 'GET');
    if (result.hasValue()) {
      return Result(
          value: ArtistMapper.fromJsonList(result.value.data['data']),
          error: null);
    } else {
      return Result(value: null, error: Error());
    }
  }
}
