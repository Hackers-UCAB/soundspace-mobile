import '../../../common/result.dart';
import '../album.dart';

abstract class AlbumRepository {
  Future<Result<List<Album>>> getTrendingAlbums();
  Future<Result<Album>> getAlbumById(String albumId);
}
