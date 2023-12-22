import 'package:sign_in_bloc/domain/song/song.dart';
import '../../../common/result.dart';
import '../../../domain/artist/artist.dart';
import '../../../domain/song/repository/song_repository.dart';

class GetSongsByArtistUseCase {
  final SongRepository songRepository;

  GetSongsByArtistUseCase({required this.songRepository});

  Future<Result<List<Song>>> execute(Artist artist) async {
    return await songRepository.getSongsByArtistId(artist.id);
  }
}
