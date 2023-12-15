import '../../../domain/artist/artist.dart';
import '../../../domain/artist/repository/artist_repository.dart';
import '../../../common/result.dart';

class GetTrendingArtistsUseCase {
  final ArtistRepository artistRepository;

  GetTrendingArtistsUseCase({required this.artistRepository});

  Future<Result<List<Artist>>> execute() async {
    return await artistRepository.getTrendingArtists();
  }
}
