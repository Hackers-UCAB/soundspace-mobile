import 'package:bloc/bloc.dart';
import 'package:sign_in_bloc/application/use_cases/artist/get_artist_data_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:sign_in_bloc/domain/artist/artist.dart';
import '../../../common/failure.dart';
part 'artist_detail_event.dart';
part 'artist_detail_state.dart';

class ArtistDetailBloc extends Bloc<ArtistDetailEvent, ArtistDetailState> {
  final GetArtistDataUseCase getArtistDataUseCase;

  ArtistDetailBloc({required this.getArtistDataUseCase})
      : super(ArtistDetailLoading()) {
    on<FetchArtistDetailEvent>(_fetchArtistDetailsEventHandler);
  }
  //TODO: Esto es asi casi para el 99.9% de los fetchs handlers, puede optimizarse
  void _fetchArtistDetailsEventHandler(
      FetchArtistDetailEvent event, Emitter<ArtistDetailState> emit) async {
    final result = await getArtistDataUseCase
        .execute(GetArtistDataUseCaseInput(artistId: event.artistId));
    if (result.hasValue()) {
      final Artist artist = result.value!;
      emit(ArtistDetailLoaded(artist: artist));
    } else {
      emit(ArtistDetailFailed(failure: result.failure!));
    }
  }
}
