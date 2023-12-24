import 'package:bloc/bloc.dart';
import 'package:sign_in_bloc/application/use_cases/album/get_albums_by_artist_use_case.dart';
import 'package:sign_in_bloc/application/use_cases/artist/get_artist_data_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:sign_in_bloc/application/use_cases/song/get_songs_by_artist_use_case.dart';
import 'package:sign_in_bloc/domain/artist/artist.dart';
import 'package:sign_in_bloc/domain/album/album.dart';
import '../../../common/failure.dart';
import '../../../domain/song/song.dart';
part 'artist_detail_event.dart';
part 'artist_detail_state.dart';

class ArtistDetailBloc extends Bloc<ArtistDetailEvent, ArtistDetailState> {
  final GetArtistDataUseCase getArtistDataUseCase;
  final GetAlbumsByArtistUseCase getAlbumsByArtistUseCase;
  final GetSongsByArtistUseCase getSongsByArtistUseCase;

  ArtistDetailBloc(
      {required this.getArtistDataUseCase,
      required this.getAlbumsByArtistUseCase,
      required this.getSongsByArtistUseCase})
      : super(ArtistDetailLoading()) {
    on<FetchArtistDetailEvent>(_fetchArtistDetailsEventHandler);
  }

  void _fetchArtistDetailsEventHandler(
      FetchArtistDetailEvent event, Emitter<ArtistDetailState> emit) async {
    final artistDataResult = await getArtistDataUseCase.execute(event.artistId);
    final albumsByArtistResult =
        await getAlbumsByArtistUseCase.execute(event.artistId);
    final songByAlbumResult =
        await getSongsByArtistUseCase.execute(event.artistId);

    if ([artistDataResult, albumsByArtistResult, songByAlbumResult]
        .every((result) => result.hasValue())) {
      emit(ArtistDetailLoaded(
          artistData: artistDataResult.value!,
          artistAlbums: albumsByArtistResult.value!,
          artistSongs: songByAlbumResult.value!));
    } else {
      emit(ArtistDetailFailed(
          failure: artistDataResult
              .failure!)); //TODO: Esto tengo que arreglarlo cuando terminemos de unir todo
    }
  }
}
