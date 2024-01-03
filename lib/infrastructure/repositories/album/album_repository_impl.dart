import 'package:sign_in_bloc/domain/album/repository/album_repository.dart';
import 'package:sign_in_bloc/infrastructure/mappers/album/album_mapper.dart';
import 'package:sign_in_bloc/infrastructure/datasources/api/api_connection_manager.dart';
import 'package:sign_in_bloc/common/result.dart';
import '../../../domain/album/album.dart';

class AlbumRepositoryImpl extends AlbumRepository {
  final IApiConnectionManager _apiConnectionManager;

  AlbumRepositoryImpl({required IApiConnectionManager apiConnectionManager})
      : _apiConnectionManager = apiConnectionManager;

  @override
  Future<Result<List<Album>>> getTrendingAlbums() async {
    final result = await _apiConnectionManager.request<List<Album>>(
        'playlist/top_playlists?type=album', //TODO: el type es un query param
        'GET',
        (data) => AlbumMapper.fromJsonList(data['data']));
    return result;
  }

  @override
  Future<Result<Album>> getAlbumById(String albumId) async {
    return await _apiConnectionManager.request<Album>(
      'albums/$albumId',
      'GET',
      (data) => AlbumMapper.fromJson(data['data']),
    );
  }
}
