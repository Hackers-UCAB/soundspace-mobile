import 'package:sign_in_bloc/domain/album/album.dart';

import '../../../common/result.dart';
import '../../../domain/song/repository/song_repository.dart';
import '../../../domain/song/song.dart';

class GetSongsByAlbumUseCase {
  final SongRepository songRepository;

  GetSongsByAlbumUseCase({required this.songRepository});

  Future<Result<List<Song>>> execute(Album album) async {
    return await songRepository.getSongsByAlbumId(album.id);
  }
}
