// ignore_for_file: prefer_null_aware_operators

import 'package:sign_in_bloc/domain/album/album.dart';
import 'package:sign_in_bloc/domain/playlist/playlist.dart';
import 'package:sign_in_bloc/domain/song/song.dart';
import 'package:sign_in_bloc/infrastructure/datasources/api/api_connection_manager.dart';
import 'package:sign_in_bloc/infrastructure/mappers/album/album_mapper.dart';
import 'package:sign_in_bloc/infrastructure/mappers/artist/artist_mapper.dart';
import 'package:sign_in_bloc/infrastructure/mappers/playlist/playlist_mapper.dart';
import 'package:sign_in_bloc/infrastructure/mappers/song/song_mapper.dart';

import '../../common/result.dart';
import '../../domain/artist/artist.dart';
import '../../domain/services/search_entities_by_name.dart';

class SearchEntitiesByNameImpl implements SearchEntitiesByName {
  final IApiConnectionManager _apiConnectionManager;

  SearchEntitiesByNameImpl(
      {required IApiConnectionManager apiConnectionManager})
      : _apiConnectionManager = apiConnectionManager;

  @override
  Future<Result<EntitiesByName>> call(
      String name, List<String>? entitiesFilter) async {
    final result = await _apiConnectionManager
        .request<EntitiesByName>('search/$name', 'GET', (data) {
      final albums = data['album'] != null
          ? data['album']
              .map<Album>((e) => AlbumMapper.fromJsonList(e))
              .toList()
          : null;
      final artists = data['artist'] != null
          ? ArtistMapper.fromJsonList(data['artist'])
          : null;
      final playlists = data['playlist'] != null
          ? PlaylistMapper.fromJsonList(data['playlist'])
          : null;
      final songs =
          data['song'] != null ? SongMapper.fromJsonList(data['song']) : null;

      return EntitiesByName(
        albums: albums,
        artists: artists,
        playlists: playlists,
        songs: songs,
      );
    }, queryParameters: {'type': entitiesFilter});

    return result;
  }
}
