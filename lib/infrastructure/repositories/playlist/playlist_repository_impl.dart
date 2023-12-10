import 'package:sign_in_bloc/domain/playlist/repository/playlist_repository.dart';
import 'package:sign_in_bloc/infrastructure/mappers/playlist/playlist_mapper.dart';
import 'package:sign_in_bloc/infrastructure/services/api_connection_manager.dart';
import 'package:sign_in_bloc/commons/result.dart';
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
      return Result(
          value: PlaylistMapper.fromJsonList(result.value.data['data']),
          error: null);
    } else {
      return Result(value: null, error: Error());
    }
  }
}
