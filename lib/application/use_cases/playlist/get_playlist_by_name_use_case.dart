import 'package:sign_in_bloc/domain/playlist/playlist.dart';
import '../../../common/result.dart';
import '../../../common/use_case.dart';
import '../../../domain/playlist/repository/playlist_repository.dart';

class GetPlaylistByNameUseCaseInput extends IUseCaseInput {
  final String name;

  GetPlaylistByNameUseCaseInput({required this.name});
}

class GetPlaylistByNameUseCase
    extends IUseCase<GetPlaylistByNameUseCaseInput, List<Playlist>> {
  final PlaylistRepository _playlistRepository;

  GetPlaylistByNameUseCase({required PlaylistRepository playlistRepository})
      : _playlistRepository = playlistRepository;

  @override
  Future<Result<List<Playlist>>> execute(
      GetPlaylistByNameUseCaseInput params) async {
    return await Future.sync(() => Result<List<Playlist>>(value: [
          Playlist(id: 'id', name: 'name', image: [0, 0, 0, 0])
        ]));
    // return await _artistRepository.getArtistByName(params.name);
  }
}
