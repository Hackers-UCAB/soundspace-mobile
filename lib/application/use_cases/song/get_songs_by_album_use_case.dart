import '../../../common/result.dart';
import '../../../common/use_case.dart';
import '../../../domain/song/repository/song_repository.dart';
import '../../../domain/song/song.dart';

class GetSongsByAlbumUseCaseInput extends IUseCaseInput {
  final String albumId;

  GetSongsByAlbumUseCaseInput({required this.albumId});
}

class GetSongsByAlbumUseCase
    extends IUseCase<GetSongsByAlbumUseCaseInput, List<Song>> {
  final SongRepository songRepository;

  GetSongsByAlbumUseCase({required this.songRepository});

  @override
  Future<Result<List<Song>>> execute(GetSongsByAlbumUseCaseInput params) async {
    return await songRepository.getSongsByAlbumId(params.albumId);
  }
}
