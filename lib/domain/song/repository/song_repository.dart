import '../../../common/result.dart';
import '../song.dart';

abstract class SongRepository {
  Future<Result<List<Song>>> getSongs();
  Future<Result<List<Song>>> getSongsByAlbumId(String albumId);
  Future<Result<List<Song>>> getSongsByArtistId(String artistId);
}
