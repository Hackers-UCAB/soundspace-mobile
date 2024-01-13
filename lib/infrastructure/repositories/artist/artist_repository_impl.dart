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
    return await _apiConnectionManager.request<List<Artist>>(
        'artist/top_artist',
        'GET',
        (data) => ArtistMapper.fromJsonList(data['artists']));
  }

  @override
  Future<Result<Artist>> getArtistById(String artistId) async {
    return await _apiConnectionManager.request<Artist>(
      'artist/$artistId',
      'GET',
      (data) => ArtistMapper.fromJson(data),
    );
  }
}
