import '../../../domain/album/album.dart';
import '../../../domain/album/repository/album_repository.dart';
import '../../../common/result.dart';

class GetAlbumsByArtistUseCase {
  final AlbumRepository albumRepository;

  GetAlbumsByArtistUseCase({required this.albumRepository});

  Future<Result<List<Album>>> execute(String artistId) async {
    return await albumRepository.getAlbumsByArtistId(artistId);
  }
}
