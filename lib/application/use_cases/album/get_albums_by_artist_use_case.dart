import '../../../domain/album/album.dart';
import '../../../domain/album/repository/album_repository.dart';
import '../../../common/result.dart';
import '../../../domain/artist/artist.dart';

class GetAlbumsByArtistUseCase {
  final AlbumRepository albumRepository;

  GetAlbumsByArtistUseCase({required this.albumRepository});

  Future<Result<List<Album>>> execute(Artist artist) async {
    return await albumRepository.getAlbumsByArtistId(artist.id);
  }
}
