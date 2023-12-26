import 'package:sign_in_bloc/domain/song/song.dart';
import '../../../common/result.dart';
import '../../../common/use_case.dart';
import '../../../domain/song/repository/song_repository.dart';

class GetSongsByArtistUseCaseInput extends IUseCaseInput {
  final String artistId;

  GetSongsByArtistUseCaseInput({required this.artistId});
}

class GetSongsByArtistUseCase
    extends IUseCase<GetSongsByArtistUseCaseInput, List<Song>> {
  final SongRepository songRepository;

  GetSongsByArtistUseCase({required this.songRepository});

  @override
  Future<Result<List<Song>>> execute(
      GetSongsByArtistUseCaseInput params) async {
    return await songRepository.getSongsByArtistId(params.artistId);
  }
}
