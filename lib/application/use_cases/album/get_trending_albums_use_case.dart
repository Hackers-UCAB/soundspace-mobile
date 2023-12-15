import 'package:sign_in_bloc/domain/album/album.dart';

import '../../../domain/album/repository/album_repository.dart';
import '../../../common/result.dart';

class GetTrendingAlbumsUseCase {
  final AlbumRepository albumRepository;

  GetTrendingAlbumsUseCase({required this.albumRepository});

  Future<Result<List<Album>>> execute() async {
    return await albumRepository.getTrendingAlbums();
  }
}
