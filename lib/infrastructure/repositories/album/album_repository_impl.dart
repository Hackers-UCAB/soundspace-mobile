import 'package:sign_in_bloc/domain/album/repository/album_repository.dart';
import 'package:sign_in_bloc/domain/artist/artist.dart';
import 'package:sign_in_bloc/infrastructure/mappers/album/album_mapper.dart';
import 'package:sign_in_bloc/infrastructure/datasources/api/api_connection_manager.dart';
import 'package:sign_in_bloc/common/result.dart';
import '../../../domain/album/album.dart';

class AlbumRepositoryImpl extends AlbumRepository {
  final IApiConnectionManager _apiConnectionManager;

  AlbumRepositoryImpl({required IApiConnectionManager apiConnectionManager})
      : _apiConnectionManager = apiConnectionManager;
//mejorar esto

  @override
  Future<Result<List<Album>>> getTrendingAlbums() async {
    final result = await _apiConnectionManager.request(
        'playlist/top_playlists?type=album',
        'GET'); //TODO: el type seria un query param? hacer prueba
    if (result.hasValue()) {
      return Result<List<Album>>(
          value: AlbumMapper.fromJsonList(result.value.data['data']));
    } else {
      return Result<List<Album>>(failure: result.failure);
    }
  }

  @override
  Future<Result<Album>> getAlbumData() async {
    final result = await _apiConnectionManager.request('albums/albums', 'GET');
    if (result.hasValue()) {
      return Result<Album>(
          value: AlbumMapper.fromJson(result.value.data['data']));
    } else {
      return Result<Album>(failure: result.failure);
    }
  }

  @override
  Future<Result<List<Album>>> getAlbumsByArtist(Artist artist) async {
    final result = await _apiConnectionManager.request('albums/albums', 'GET');
    if (result.hasValue()) {
      return Result<List<Album>>(
          value: AlbumMapper.fromJsonList(result.value.data['data']));
    } else {
      return Result<List<Album>>(failure: result.failure);
    }
  }
}
