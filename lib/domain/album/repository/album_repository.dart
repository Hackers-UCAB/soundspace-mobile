import 'package:sign_in_bloc/domain/artist/artist.dart';

import '../../../common/result.dart';
import '../album.dart';

abstract class AlbumRepository {
  Future<Result<List<Album>>> getTrendingAlbums();
  Future<Result<Album>> getAlbumData();
  Future<Result<List<Album>>> getAlbumsByArtist(Artist artist);
}
