import 'package:bloc/bloc.dart';
import 'package:sign_in_bloc/application/use_cases/playlist/get_trending_playlists_use_case.dart';
import 'package:sign_in_bloc/application/use_cases/promotional_banner/get_promotional_banner_use_case.dart';
import 'package:sign_in_bloc/application/use_cases/song/get_trending_songs_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:sign_in_bloc/domain/artist/artist.dart';
import 'package:sign_in_bloc/domain/album/album.dart';
import 'package:sign_in_bloc/domain/promotional_banner/promotional_banner.dart';
import 'package:sign_in_bloc/domain/playlist/playlist.dart';
import '../../../domain/song/song.dart';
import '../../use_cases/album/get_trending_albums_use_case.dart';
import '../../use_cases/artist/get_trending_artists_use_case.dart';
part 'trendings_event.dart';
part 'trendings_state.dart';

class TrendingsBloc extends Bloc<TrendingsEvent, TrendingsState> {
  final GetTrendingArtistsUseCase getTrendingArtistsUseCase;

  final GetTrendingAlbumsUseCase getTrendingAlbumsUseCase;
  final GetPromotionalBannerUseCase getPromotionalBannerUseCase;

  final GetTrendingPlaylistsUseCase getTrendingPlaylistsUseCase;

  final GetTrendingSongsUseCase getTrendingSongsUseCase;

  TrendingsBloc(
      {required this.getTrendingArtistsUseCase,
      required this.getTrendingAlbumsUseCase,
      required this.getPromotionalBannerUseCase,
      required this.getTrendingPlaylistsUseCase,
      required this.getTrendingSongsUseCase})
      : super(TrendingsLoading()) {
    on<FetchTrendingsEvent>(_fetchTrendingsEventHandler);
  }

  void _fetchTrendingsEventHandler(
      FetchTrendingsEvent event, Emitter<TrendingsState> emit) async {
    final trendingArtistsResult = await getTrendingArtistsUseCase.execute();
    final promotionalBannerResult = await getPromotionalBannerUseCase.execute();
    final trendingAlbumsResult = await getTrendingAlbumsUseCase.execute();
    final trendingPlaylistsResult = await getTrendingPlaylistsUseCase.execute();
    final trendingSongsResult = await getTrendingSongsUseCase.execute();

    if ([
      trendingArtistsResult,
      promotionalBannerResult,
      trendingAlbumsResult,
      trendingPlaylistsResult,
      trendingSongsResult
    ].every((result) => result.hasValue())) {
      emit(TrendingsLoaded(
        trendingArtists: trendingArtistsResult.value!,
        trendingAlbums: trendingAlbumsResult.value!,
        promotionalBanner: promotionalBannerResult.value!,
        trendingPlaylists: trendingPlaylistsResult.value!,
        trendingSongs: trendingSongsResult.value!,
      ));
    } else {
      emit(
          TrendingsFailed()); //TODO: verificar si la unica razon por la que esto falle es por falta de internet
    }
  }
}
