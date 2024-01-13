import 'package:sign_in_bloc/domain/album/album.dart';

import '../../../common/use_case.dart';
import '../../../domain/album/repository/album_repository.dart';
import '../../../common/result.dart';

class GetTrendingAlbumsUseCaseInput extends IUseCaseInput {}

class GetTrendingAlbumsUseCase
    extends IUseCase<GetTrendingAlbumsUseCaseInput, List<Album>> {
  final AlbumRepository albumRepository;

  GetTrendingAlbumsUseCase({required this.albumRepository});

  @override
  Future<Result<List<Album>>> execute(
      GetTrendingAlbumsUseCaseInput params) async {
    return await albumRepository.getTrendingAlbums();
  }
}
