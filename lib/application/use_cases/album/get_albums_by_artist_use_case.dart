import '../../../common/use_case.dart';
import '../../../domain/album/album.dart';
import '../../../domain/album/repository/album_repository.dart';
import '../../../common/result.dart';

class GetAlbumsByArtistUseCaseInput extends IUseCaseInput {
  final String artistId;

  GetAlbumsByArtistUseCaseInput({required this.artistId});
}

class GetAlbumsByArtistUseCase
    extends IUseCase<GetAlbumsByArtistUseCaseInput, List<Album>> {
  final AlbumRepository albumRepository;

  GetAlbumsByArtistUseCase({required this.albumRepository});

  @override
  Future<Result<List<Album>>> execute(
      GetAlbumsByArtistUseCaseInput params) async {
    return await albumRepository.getAlbumsByArtistId(params.artistId);
  }
}
