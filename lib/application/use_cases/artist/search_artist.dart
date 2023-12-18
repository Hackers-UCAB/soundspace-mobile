import '../../../domain/artist/artist.dart';
import '../../../domain/artist/repository/artist_repository.dart';
import '../../../common/result.dart';

class SearchArtistsUseCase {
  final ArtistRepository artistRepository;

  SearchArtistsUseCase({required this.artistRepository});

  // Future<Result<List<Artist>>> execute(String name) async {
  //   return await artistRepository.getArtistByName(name);
  // }
}
