import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/player/player_bloc.dart';
import 'package:sign_in_bloc/application/use_cases/playlist/get_playlist_data_use_case.dart';
import 'package:sign_in_bloc/common/failure.dart';
import 'package:sign_in_bloc/domain/playlist/playlist.dart';

part 'playlist_detail_event.dart';
part 'playlist_detail_state.dart';

class PlaylistDetailBloc
    extends Bloc<PlaylistDetailEvent, PlaylistDetailState> {
  final GetPlaylistDataUseCase getPlaylistDataUseCase;

  PlaylistDetailBloc({required this.getPlaylistDataUseCase})
      : super(PlaylistDetailLoading()) {
    on<FetchPlaylistDetailEvent>(_fetchPlaylistDetailEventHandler);
  }

  void _fetchPlaylistDetailEventHandler(
      FetchPlaylistDetailEvent event, Emitter<PlaylistDetailState> emit) async {
    emit(PlaylistDetailLoading());
    final result = await getPlaylistDataUseCase
        .execute(GetPlaylistDataUseCaseInput(playlistId: event.playlistId));

    if (result.hasValue()) {
      final Playlist playlist = result.value!;
      emit(PlaylistDetailLoaded(playlist: playlist));

      GetIt.instance.get<PlayerBloc>().add(UpdatePlaylist(playlist.songs!));
    } else {
      emit(PlaylistDetailFailed(failure: result.failure!));
    }
  }
}
