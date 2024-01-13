// ignore_for_file: prefer_null_aware_operators
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
      String name, List<String>? entitiesFilter, int limit, int offset) async {
    final result = await _apiConnectionManager
        .request<EntitiesByName>('search/$name', 'GET', (data) {
      final albums = data['album'] != null && data['album'].isNotEmpty
          ? AlbumMapper.fromJsonList(data['album'])
          : null;
      final artists = data['artist'] != null && data['artist'].isNotEmpty
          ? ArtistMapper.fromJsonList(data['artist'])
          : null;
      final playlists = data['playlist'] != null && data['playlist'].isNotEmpty
          ? PlaylistMapper.fromJsonList(data['playlist'])
          : null;
      final songs = data['song'] != null && data['song'].isNotEmpty
          ? SongMapper.fromJsonList(data['song'])
          : null;

      return EntitiesByName(
        albums: albums,
        artists: artists,
        playlists: playlists,
        songs: songs,
      );
    }, queryParameters: {
      'type': entitiesFilter,
      'limit': limit,
      'offset': offset
    });

    return result;
  }
}
