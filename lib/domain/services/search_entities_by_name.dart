import 'package:sign_in_bloc/domain/artist/artist.dart';
import 'package:sign_in_bloc/domain/playlist/playlist.dart';
import 'package:sign_in_bloc/domain/song/song.dart';

import '../../common/result.dart';
import '../album/album.dart';

abstract class SearchEntitiesByName {
  Future<Result<EntitiesByName>> call(
      String name, List<String>? entitiesFilter);
}

class EntitiesByName {
  final List<Album>? albums;
  final List<Artist>? artists;
  final List<Playlist>? playlists;
  final List<Song>? songs;

  EntitiesByName({
    this.albums,
    this.artists,
    this.playlists,
    this.songs,
  });
}
