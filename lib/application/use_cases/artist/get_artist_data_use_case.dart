import '../../../domain/artist/artist.dart';
import '../../../domain/artist/repository/artist_repository.dart';
import '../../../common/result.dart';

class GetArtistDataUseCase {
  final ArtistRepository artistRepository;

  GetArtistDataUseCase({required this.artistRepository});

  Future<Result<Artist>> execute(String artistId) async {
    return await artistRepository.getArtistById(artistId);
  }
}
