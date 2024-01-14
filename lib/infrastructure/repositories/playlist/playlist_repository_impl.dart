import 'package:sign_in_bloc/domain/playlist/repository/playlist_repository.dart';
import 'package:sign_in_bloc/infrastructure/mappers/playlist/playlist_mapper.dart';
import 'package:sign_in_bloc/infrastructure/datasources/api/api_connection_manager.dart';
import 'package:sign_in_bloc/common/result.dart';
import '../../../domain/playlist/playlist.dart';

class PlaylistRepositoryImpl extends PlaylistRepository {
  final IApiConnectionManager _apiConnectionManager;

  PlaylistRepositoryImpl({required IApiConnectionManager apiConnectionManager})
      : _apiConnectionManager = apiConnectionManager;

  @override
  Future<Result<List<Playlist>>> getPlayList() async {
    return await _apiConnectionManager.request<List<Playlist>>(
      'playlist/top_playlists',
      'GET',
      (data) => PlaylistMapper.fromJsonList(data['playlists']),
    );
  }

  @override
  Future<Result<Playlist>> getPlaylitsById(String playlitsId) async {
    return await _apiConnectionManager.request<Playlist>(
      'playlist/$playlitsId',
      'GET',
      (data) => PlaylistMapper.fromJson(data),
    );
  }
}
