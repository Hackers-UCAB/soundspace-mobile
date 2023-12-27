import 'package:bloc/bloc.dart';
import 'package:sign_in_bloc/application/use_cases/album/get_albums_by_artist_use_case.dart';
import 'package:sign_in_bloc/application/use_cases/artist/get_artist_data_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:sign_in_bloc/application/use_cases/song/get_songs_by_artist_use_case.dart';
import 'package:sign_in_bloc/domain/artist/artist.dart';
import 'package:sign_in_bloc/domain/album/album.dart';
import '../../../common/failure.dart';
import '../../../common/result.dart';
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
  //Esto es asi casi para el 99.9% de los fetchs handlers, puede optimizarse
  void _fetchArtistDetailsEventHandler(
      FetchArtistDetailEvent event, Emitter<ArtistDetailState> emit) async {
    final useCases = <Map<String, dynamic>>[
      {
        'input': GetArtistDataUseCaseInput(artistId: event.artistId),
        'useCase': getArtistDataUseCase
      },
      {
        'input': GetAlbumsByArtistUseCaseInput(artistId: event.artistId),
        'useCase': getAlbumsByArtistUseCase
      },
      {
        'input': GetSongsByArtistUseCaseInput(artistId: event.artistId),
        'useCase': getSongsByArtistUseCase
      }
    ];

    List<Result> results = [];

    for (final useCase in useCases) {
      final result =
          await useCase['useCase']!.execute(useCase['input']!) as Result;
      if (!result.hasValue()) {
        emit(ArtistDetailFailed(failure: result.failure!));
        return;
      } else {
        results.add(result);
      }
    }

    emit(ArtistDetailLoaded(
        artistData: results[0].value as Artist,
        artistAlbums: results[1].value as List<Album>,
        artistSongs: results[2].value as List<Song>));
  }
}
