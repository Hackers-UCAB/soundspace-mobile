import '../../../common/result.dart';
import '../artist.dart';

abstract class ArtistRepository {
  Future<Result<List<Artist>>> getTrendingArtists();
}
