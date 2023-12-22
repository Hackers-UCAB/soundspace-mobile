import 'package:bloc/bloc.dart';
import 'package:sign_in_bloc/application/use_cases/album/get_album_data_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:sign_in_bloc/domain/album/album.dart';
import 'package:sign_in_bloc/domain/song/song.dart';
import '../../../common/failure.dart';
import '../../use_cases/song/get_songs_by_album_use_case.dart';
part 'album_detail_event.dart';
part 'album_detail_state.dart';

class AlbumDetailBloc extends Bloc<AlbumDetailEvent, AlbumDetailState> {
  final GetAlbumDataUseCase getAlbumDataUseCase;
  final GetSongsByAlbumUseCase getSongsByAlbumUseCase;

  AlbumDetailBloc(
      {required this.getAlbumDataUseCase, required this.getSongsByAlbumUseCase})
      : super(AlbumDetailLoading()) {
    on<FetchAlbumDetailEvent>(_fetchAlbumDetailEventHandler);
  }

  void _fetchAlbumDetailEventHandler(
      FetchAlbumDetailEvent event, Emitter<AlbumDetailState> emit) async {
    final albumDataResult = await getAlbumDataUseCase.execute(event.album);
    final songsByAlbumResult =
        await getSongsByAlbumUseCase.execute(event.album);

    if ([
      albumDataResult,
      songsByAlbumResult,
    ].every((result) => result.hasValue())) {
      emit(AlbumDetailLoaded(
        albumData: albumDataResult.value!,
        songsByAlbum: songsByAlbumResult.value!,
      ));
    } else {
      emit(AlbumDetailFailed(
          failure: albumDataResult
              .failure!)); //TODO: Esto tengo que arreglarlo cuando terminemos de unir todo
    }
  }
}
