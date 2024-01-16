import 'package:sign_in_bloc/infrastructure/datasources/api/api_connection_manager.dart';
import 'package:sign_in_bloc/infrastructure/mappers/album/album_mapper.dart';
import 'package:sign_in_bloc/infrastructure/mappers/artist/artist_mapper.dart';
import 'package:sign_in_bloc/infrastructure/mappers/playlist/playlist_mapper.dart';
import 'package:sign_in_bloc/infrastructure/mappers/song/song_mapper.dart';
import '../../common/result.dart';
import '../../domain/services/search_entities_by_name.dart';

class SearchEntitiesByNameImpl implements SearchEntitiesByName {
  final IApiConnectionManager _apiConnectionManager;

  SearchEntitiesByNameImpl(
      {required IApiConnectionManager apiConnectionManager})
      : _apiConnectionManager = apiConnectionManager;

  @override
  Future<Result<EntitiesByName>> call(
      String name, String? entitiesFilter, int limit, int offset) async {
    final result = await _apiConnectionManager
        .request<EntitiesByName>('search/$name', 'GET', (data) {
      final albums = data['albums'] != null && data['albums'].isNotEmpty
          ? AlbumMapper.fromJsonList(data['albums'])
          : null;
      final artists = data['artists'] != null && data['artists'].isNotEmpty
          ? ArtistMapper.fromJsonList(data['artists'])
          : null;
      final playlists =
          data['playlists'] != null && data['playlists'].isNotEmpty
              ? PlaylistMapper.fromJsonList(data['playlists'])
              : null;
      final songs = data['songs'] != null && data['songs'].isNotEmpty
          ? SongMapper.fromJsonList(data['songs'])
          : null;

      return EntitiesByName(
        albums: albums,
        artists: artists,
        playlists: playlists,
        songs: songs,
      );
    }, queryParameters: {
      if (entitiesFilter != null) 'type': entitiesFilter,
      'limit': limit,
      'offset': offset
    });

    return result;
  }
}
