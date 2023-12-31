import 'package:sign_in_bloc/common/use_case.dart';
import '../../../common/result.dart';
import '../../../domain/album/album.dart';
import '../../../domain/album/repository/album_repository.dart';

class GetAlbumByNameUseCaseInput extends IUseCaseInput {
  final String name;

  GetAlbumByNameUseCaseInput({required this.name});
}

class GetAlbumByNameUseCase
    extends IUseCase<GetAlbumByNameUseCaseInput, List<Album>> {
  final AlbumRepository _albumRepository;

  GetAlbumByNameUseCase({required AlbumRepository albumRepository})
      : _albumRepository = albumRepository;

  @override
  Future<Result<List<Album>>> execute(GetAlbumByNameUseCaseInput params) async {
    //FIXME: Hardcodeadisimo
    return await Future.delayed(
        const Duration(seconds: 10),
        () => Result<List<Album>>(value: [
              Album(id: 'id', name: 'name', image: [1])
            ])); //
    // return await _albumRepository.getAlbumByName(params.name);
  }
}
