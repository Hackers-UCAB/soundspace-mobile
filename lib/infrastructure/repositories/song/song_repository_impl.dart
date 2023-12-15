import 'package:sign_in_bloc/domain/song/repository/song_repository.dart';
import 'package:sign_in_bloc/infrastructure/mappers/song/song_mapper.dart';
import 'package:sign_in_bloc/infrastructure/datasources/api/api_connection_manager.dart';
import 'package:sign_in_bloc/common/result.dart';
import '../../../domain/song/song.dart';

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
          error: null);
    } else {
      return Result(value: null, error: Error());
    }
  }
}
