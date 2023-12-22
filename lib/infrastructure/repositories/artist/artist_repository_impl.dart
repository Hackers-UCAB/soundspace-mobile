import 'package:sign_in_bloc/domain/artist/repository/artist_repository.dart';
import 'package:sign_in_bloc/infrastructure/mappers/artist/artist_mapper.dart';
import 'package:sign_in_bloc/infrastructure/datasources/api/api_connection_manager.dart';
import 'package:sign_in_bloc/common/result.dart';
import '../../../domain/artist/artist.dart';

class ArtistRepositoryImpl extends ArtistRepository {
  final IApiConnectionManager _apiConnectionManager;

  ArtistRepositoryImpl({required IApiConnectionManager apiConnectionManager})
      : _apiConnectionManager = apiConnectionManager;

  @override
  Future<Result<List<Artist>>> getTrendingArtists() async {
    final result =
        await _apiConnectionManager.request('artists/top_artists', 'GET');
    if (result.hasValue()) {
      return Result<List<Artist>>(
        value: ArtistMapper.fromJsonList(result.value.data['data']),
      );
    } else {
      return Result<List<Artist>>(failure: result.failure);
    }
  }

  @override
  Future<Result<Artist>> getArtistById(String artistId) async {
    final result = await _apiConnectionManager.request(
        'artists/$artistId', 'GET'); //TODO: Preguntar al back
    if (result.hasValue()) {
      return Result<Artist>(
        value: ArtistMapper.fromJson(result.value.data['data']),
      );
    } else {
      return Result<Artist>(failure: result.failure);
    }
  }
}
