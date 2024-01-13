import 'package:sign_in_bloc/common/result.dart';
import 'package:sign_in_bloc/common/use_case.dart';
import 'package:sign_in_bloc/domain/playlist/playlist.dart';
import 'package:sign_in_bloc/domain/playlist/repository/playlist_repository.dart';

class GetPlaylistDataUseCaseInput extends IUseCaseInput {
  final String playlistId;

  GetPlaylistDataUseCaseInput({required this.playlistId});
}

class GetPlaylistDataUseCase
    extends IUseCase<GetPlaylistDataUseCaseInput, Playlist> {
  final PlaylistRepository playlistRepository;

  GetPlaylistDataUseCase({required this.playlistRepository});
  @override
  Future<Result<Playlist>> execute(GetPlaylistDataUseCaseInput params) async {
    return await playlistRepository.getPlaylitsById(params.playlistId);
  }
}
