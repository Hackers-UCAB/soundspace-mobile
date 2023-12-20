import 'package:sign_in_bloc/domain/playlist/repository/playlist_repository.dart';
import 'package:sign_in_bloc/infrastructure/mappers/playlist/playlist_mapper.dart';
import 'package:sign_in_bloc/infrastructure/datasources/api/api_connection_manager.dart';
import 'package:sign_in_bloc/common/result.dart';
import '../../../domain/playlist/playlist.dart';

class PlaylistRepositoryImpl extends PlaylistRepository {
  final IApiConnectionManager _apiConnectionManager;

  PlaylistRepositoryImpl({required IApiConnectionManager apiConnectionManager})
      : _apiConnectionManager = apiConnectionManager;
  //mejorar esto

  @override
  Future<Result<List<Playlist>>> getPlayList() async {
    final result =
        await _apiConnectionManager.request('playlist/top_playlists', 'GET');
    if (result.hasValue()) {
      return Result<List<Playlist>>(
        value: PlaylistMapper.fromJsonList(result.value.data['data']),
      );
    } else {
      return Result<List<Playlist>>(failure: result.failure);
    }
  }
}
