import '../../../domain/album/album.dart';
import '../../../domain/album/repository/album_repository.dart';
import '../../../common/result.dart';

class GetAlbumDataUseCase {
  final AlbumRepository albumRepository;

  GetAlbumDataUseCase({required this.albumRepository});

  Future<Result<Album>> execute() async {
    return await albumRepository.getAlbumData();
  }
}
