import '../../../common/result.dart';
import '../playlist.dart';

abstract class PlaylistRepository {
  Future<Result<List<Playlist>>> getPlayList();
}
