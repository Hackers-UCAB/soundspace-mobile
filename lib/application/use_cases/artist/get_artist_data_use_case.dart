import '../../../common/use_case.dart';
import '../../../domain/artist/artist.dart';
import '../../../domain/artist/repository/artist_repository.dart';
import '../../../common/result.dart';

class GetArtistDataUseCaseInput extends IUseCaseInput {
  final String artistId;

  GetArtistDataUseCaseInput({required this.artistId});
}

class GetArtistDataUseCase extends IUseCase<GetArtistDataUseCaseInput, Artist> {
  final ArtistRepository artistRepository;

  GetArtistDataUseCase({required this.artistRepository});

  @override
  Future<Result<Artist>> execute(GetArtistDataUseCaseInput params) async {
    return await artistRepository.getArtistById(params.artistId);
  }
}
