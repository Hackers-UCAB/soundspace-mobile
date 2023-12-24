import 'package:sign_in_bloc/domain/song/song.dart';
import '../../../common/result.dart';
import '../../../domain/song/repository/song_repository.dart';

class GetSongsByArtistUseCase {
  final SongRepository songRepository;

  GetSongsByArtistUseCase({required this.songRepository});

  Future<Result<List<Song>>> execute(String artistId) async {
    return await songRepository.getSongsByArtistId(artistId);
  }
}
