import '../../../domain/album/album.dart';
import '../../../domain/album/repository/album_repository.dart';
import '../../../common/result.dart';
import '../../../domain/artist/artist.dart';

class GetAlbumsByArtistUseCase {
  final AlbumRepository albumRepository;
  final Artist artist;

  GetAlbumsByArtistUseCase(
      {required this.albumRepository, required this.artist});

  Future<Result<List<Album>>> execute() async {
    return await albumRepository.getAlbumsByArtist(artist);
  }
}
