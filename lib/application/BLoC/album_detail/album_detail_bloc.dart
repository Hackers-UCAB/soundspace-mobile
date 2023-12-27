import 'package:bloc/bloc.dart';
import 'package:sign_in_bloc/application/use_cases/album/get_album_data_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:sign_in_bloc/domain/album/album.dart';
import 'package:sign_in_bloc/domain/song/song.dart';
import '../../../common/failure.dart';
import '../../../common/result.dart';
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
    final useCases = <Map<String, dynamic>>[
      {
        'input': GetAlbumDataUseCaseInput(albumId: event.albumId),
        'useCase': getAlbumDataUseCase
      },
      {
        'input': GetSongsByAlbumUseCaseInput(albumId: event.albumId),
        'useCase': getSongsByAlbumUseCase
      }
    ];

    List<Result> results = [];

    for (final useCase in useCases) {
      final result =
          await useCase['useCase']!.execute(useCase['input']!) as Result;
      if (!result.hasValue()) {
        emit(AlbumDetailFailed(failure: result.failure!));
        return;
      } else {
        results.add(result);
      }
    }

    emit(AlbumDetailLoaded(
        //FIXME: sorry no encontre mejor manera de hacer esto
        albumData: results[0].value as Album,
        songsByAlbum: results[1].value as List<Song>));
  }
}
