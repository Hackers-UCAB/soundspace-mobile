import 'package:bloc/bloc.dart';
import 'package:sign_in_bloc/application/use_cases/album/get_album_data_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:sign_in_bloc/domain/album/album.dart';
import '../../../common/failure.dart';
part 'album_detail_event.dart';
part 'album_detail_state.dart';

class AlbumDetailBloc extends Bloc<AlbumDetailEvent, AlbumDetailState> {
  final GetAlbumDataUseCase getAlbumDataUseCase;

  AlbumDetailBloc({required this.getAlbumDataUseCase})
      : super(AlbumDetailLoading()) {
    on<FetchAlbumDetailEvent>(_fetchAlbumDetailEventHandler);
  }

  void _fetchAlbumDetailEventHandler(
      FetchAlbumDetailEvent event, Emitter<AlbumDetailState> emit) async {
    emit(AlbumDetailLoading());
    final result = await getAlbumDataUseCase
        .execute(GetAlbumDataUseCaseInput(albumId: event.albumId));

    if (result.hasValue()) {
      final Album album = result.value!;
      emit(AlbumDetailLoaded(album: album));
    } else {
      emit(AlbumDetailFailed(failure: result.failure!));
    }
  }
}
