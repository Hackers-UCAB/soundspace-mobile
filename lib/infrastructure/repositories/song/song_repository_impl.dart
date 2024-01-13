import 'package:sign_in_bloc/infrastructure/mappers/song/song_mapper.dart';
import 'package:sign_in_bloc/infrastructure/datasources/api/api_connection_manager.dart';
import 'package:sign_in_bloc/common/result.dart';
import '../../../domain/song/song.dart';
import '../../../domain/song/repository/song_repository.dart';

class SongRepositoryImpl extends SongRepository {
  final IApiConnectionManager _apiConnectionManager;

  SongRepositoryImpl({required IApiConnectionManager apiConnectionManager})
      : _apiConnectionManager = apiConnectionManager;

  @override
  Future<Result<List<Song>>> getTracklist() async {
    return await _apiConnectionManager.request(
      'song/top_songs',
      'GET',
      (data) => SongMapper.fromJsonList(data['songs']),
    );
  }
}
