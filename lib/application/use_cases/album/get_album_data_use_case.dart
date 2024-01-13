import '../../../common/use_case.dart';
import '../../../domain/album/album.dart';
import '../../../domain/album/repository/album_repository.dart';
import '../../../common/result.dart';

class GetAlbumDataUseCaseInput extends IUseCaseInput {
  final String albumId;

  GetAlbumDataUseCaseInput({required this.albumId});
}

class GetAlbumDataUseCase extends IUseCase<GetAlbumDataUseCaseInput, Album> {
  final AlbumRepository albumRepository;

  GetAlbumDataUseCase({required this.albumRepository});

  @override
  Future<Result<Album>> execute(GetAlbumDataUseCaseInput params) async {
    return await albumRepository.getAlbumById(params.albumId);
  }
}
