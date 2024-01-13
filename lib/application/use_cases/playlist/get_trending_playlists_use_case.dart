import '../../../common/use_case.dart';
import '../../../domain/playlist/playlist.dart';
import '../../../domain/playlist/repository/playlist_repository.dart';
import '../../../common/result.dart';

class GetTrendingPlaylistsUseCaseInput extends IUseCaseInput {}

class GetTrendingPlaylistsUseCase
    extends IUseCase<GetTrendingPlaylistsUseCaseInput, List<Playlist>> {
  final PlaylistRepository playlistRepository;

  GetTrendingPlaylistsUseCase({required this.playlistRepository});

  @override
  Future<Result<List<Playlist>>> execute(
      GetTrendingPlaylistsUseCaseInput params) async {
    return await playlistRepository.getPlayList();
  }
}
