import '../../../common/use_case.dart';
import '../../../domain/artist/artist.dart';
import '../../../domain/artist/repository/artist_repository.dart';
import '../../../common/result.dart';

class GetTrendingArtistsUseCaseInput extends IUseCaseInput {}

class GetTrendingArtistsUseCase
    extends IUseCase<GetTrendingArtistsUseCaseInput, List<Artist>> {
  final ArtistRepository artistRepository;

  GetTrendingArtistsUseCase({required this.artistRepository});

  @override
  Future<Result<List<Artist>>> execute(
      GetTrendingArtistsUseCaseInput params) async {
    return await artistRepository.getTrendingArtists();
  }
}
