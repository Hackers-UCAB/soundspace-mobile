import '../../../common/result.dart';
import '../../album/album.dart';
import '../song.dart';

abstract class SongRepository {
  Future<Result<List<Song>>> getSongs();
  Future<Result<List<Song>>> getSongsByAlbum(Album album);
}
