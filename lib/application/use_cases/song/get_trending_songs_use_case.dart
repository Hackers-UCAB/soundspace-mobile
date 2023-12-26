import '../../../common/use_case.dart';
import '../../../domain/song/song.dart';
import '../../../domain/song/repository/song_repository.dart';
import '../../../common/result.dart';

class GetTrendingSongsUseCaseInput extends IUseCaseInput {}

class GetTrendingSongsUseCase
    extends IUseCase<GetTrendingSongsUseCaseInput, List<Song>> {
  final SongRepository songRepository;

  GetTrendingSongsUseCase({required this.songRepository});

  @override
  Future<Result<List<Song>>> execute(
      GetTrendingSongsUseCaseInput params) async {
    return await songRepository.getSongs();
  }
}
