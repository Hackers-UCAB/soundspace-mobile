import '../../../common/result.dart';
import '../../../common/use_case.dart';
import '../../../domain/artist/artist.dart';
import '../../../domain/artist/repository/artist_repository.dart';

class GetArtistByNameUseCaseInput extends IUseCaseInput {
  final String name;

  GetArtistByNameUseCaseInput({required this.name});
}

class GetArtistByNameUseCase
    extends IUseCase<GetArtistByNameUseCaseInput, List<Artist>> {
  final ArtistRepository _artistRepository;

  GetArtistByNameUseCase({required ArtistRepository artistRepository})
      : _artistRepository = artistRepository;

  @override
  Future<Result<List<Artist>>> execute(
      GetArtistByNameUseCaseInput params) async {
    return await Future.sync(() => Result<List<Artist>>(value: [
          Artist(id: 'id', name: 'name', image: [0, 0, 0, 0])
        ]));
    // return await _artistRepository.getArtistByName(params.name);
  }
}
