import 'package:sign_in_bloc/infrastructure/mappers/song/song_mapper.dart';
import 'package:sign_in_bloc/infrastructure/datasources/api/api_connection_manager.dart';
import 'package:sign_in_bloc/common/result.dart';
import '../../../domain/album/album.dart';
import '../../../domain/song/song.dart';
import '../../../domain/song/repository/song_repository.dart';

class SongRepositoryImpl extends SongRepository {
  final IApiConnectionManager _apiConnectionManager;

  SongRepositoryImpl({required IApiConnectionManager apiConnectionManager})
      : _apiConnectionManager = apiConnectionManager;

  @override
  Future<Result<List<Song>>> getSongs() async {
    final result =
        await _apiConnectionManager.request('songs/tracklist', 'GET');
    if (result.hasValue()) {
      return Result(
        value: SongMapper.fromJsonList(result.value.data['data']),
      );
    } else {
      return Result(failure: result.failure);
    }
  }

  @override
  Future<Result<List<Song>>> getSongsByAlbum(Album album) async {
    final result =
        await _apiConnectionManager.request('songs/tracklist', 'GET');
    if (result.hasValue()) {
      return Result(
        value: SongMapper.fromJsonList(result.value.data['data']),
      );
    } else {
      return Result(failure: result.failure);
    }
  }
}
