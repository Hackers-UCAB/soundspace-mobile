import 'package:sign_in_bloc/domain/song/song.dart';

import '../../../domain/album/album.dart';
import '../../../common/result.dart';
import '../../../domain/song/repository/song_repository.dart';

class GetSongsByAlbumUseCase {
  final SongRepository songRepository;
  final Album album;

  GetSongsByAlbumUseCase({required this.songRepository, required this.album});

  Future<Result<List<Song>>> execute() async {
    return await songRepository.getSongsByAlbum(album);
  }
}
