import '../../../common/result.dart';
import '../artist.dart';

abstract class ArtistRepository {
  Future<Result<List<Artist>>> getTrendingArtists();
  Future<Result<Artist>> getArtistById(String artistId);
  Future<Result<List<Artist>>> getArtistByName(String name);
}
