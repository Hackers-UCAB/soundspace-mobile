import '../../../domain/album/album.dart';
import '../../../domain/album/repository/album_repository.dart';
import '../../../common/result.dart';

class GetAlbumDataUseCase {
  final AlbumRepository albumRepository;

  GetAlbumDataUseCase({required this.albumRepository});

  Future<Result<Album>> execute(Album album) async {
    return await albumRepository.getAlbumById(album.id);
  }
}
