import 'package:bloc/bloc.dart';
import 'package:sign_in_bloc/application/use_cases/album/get_albums_by_artist_use_case.dart';
import 'package:sign_in_bloc/application/use_cases/artist/get_artist_data_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:sign_in_bloc/application/use_cases/song/get_songs_by_album_use_case.dart';
import 'package:sign_in_bloc/domain/artist/artist.dart';
import 'package:sign_in_bloc/domain/album/album.dart';
import '../../../common/failure.dart';
import '../../../domain/song/song.dart';
part 'artist_detail_event.dart';
part 'artist_detail_state.dart';

class ArtistDetailBloc extends Bloc<ArtistDetailEvent, ArtistDetailState> {
  final GetArtistDataUseCase getArtistDataUseCase;
  final GetAlbumsByArtistUseCase getAlbumsByArtistUseCase;
  final GetSongsByAlbumUseCase getSongsByAlbumUseCase;

  ArtistDetailBloc(
      {required this.getArtistDataUseCase,
      required this.getAlbumsByArtistUseCase,
      required this.getSongsByAlbumUseCase})
      : super(ArtistDetailLoading()) {
    on<FetchArtistDetailEvent>(_fetchArtistDetailsEventHandler);
  }

  void _fetchArtistDetailsEventHandler(
      FetchArtistDetailEvent event, Emitter<ArtistDetailState> emit) async {
    final artistDataResult = await getArtistDataUseCase.execute();
    final albumsByArtistResult = await getAlbumsByArtistUseCase.execute();
    final songByAlbumResult = await getSongsByAlbumUseCase.execute();

    if ([artistDataResult, albumsByArtistResult, songByAlbumResult]
        .every((result) => result.hasValue())) {
      emit(ArtistDetailLoaded(
          artistData: artistDataResult.value!,
          artistAlbums: albumsByArtistResult.value!,
          artistAlbumSongs: songByAlbumResult.value!));
    } else {
      emit(ArtistDetailFailed(
          failure: artistDataResult
              .failure!)); //TODO: Esto tengo que arreglarlo cuando terminemos de unir todo
    }
  }
}
