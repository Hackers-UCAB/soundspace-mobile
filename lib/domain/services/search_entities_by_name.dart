import 'package:sign_in_bloc/domain/artist/artist.dart';
import 'package:sign_in_bloc/domain/playlist/playlist.dart';
import 'package:sign_in_bloc/domain/song/song.dart';

import '../../common/result.dart';
import '../album/album.dart';

abstract class SearchEntitiesByName {
  Future<Result<EntitiesByName>> call(
      String name, String? entitiesFilter, int limit, int offset);
}

class EntitiesByName {
  final Map<String, List<dynamic>> entitiesMap = {
    'album': [],
    'artist': [],
    'playlist': [],
    'song': [],
  };

  EntitiesByName({
    List<Album>? albums,
    List<Artist>? artists,
    List<Playlist>? playlists,
    List<Song>? songs,
  }) {
    entitiesMap['album'] = albums ?? [];
    entitiesMap['artist'] = artists ?? [];
    entitiesMap['playlist'] = playlists ?? [];
    entitiesMap['song'] = songs ?? [];
  }
}
