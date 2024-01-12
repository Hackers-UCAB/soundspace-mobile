import 'package:bloc/bloc.dart';
import 'package:sign_in_bloc/application/use_cases/playlist/get_trending_playlists_use_case.dart';
import 'package:sign_in_bloc/application/use_cases/promotional_banner/get_promotional_banner_use_case.dart';
import 'package:sign_in_bloc/application/use_cases/song/get_trending_songs_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:sign_in_bloc/common/result.dart';
import 'package:sign_in_bloc/domain/album/album.dart';
import 'package:sign_in_bloc/domain/playlist/playlist.dart';
import 'package:sign_in_bloc/domain/promotional_banner/promotional_banner.dart';
import 'package:sign_in_bloc/domain/song/song.dart';
import '../../../common/failure.dart';
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
    emit(TrendingsLoading());
    final useCases = <Map<String, dynamic>>[
      // {
      //   'input': GetTrendingArtistsUseCaseInput(),
      //   'useCase': getTrendingArtistsUseCase,
      // },
      {
        'input': GetTrendingAlbumsUseCaseInput(),
        'useCase': getTrendingAlbumsUseCase,
      },
      {
        'input': GetPromotionalBannerUseCaseInput(),
        'useCase': getPromotionalBannerUseCase,
      },
      {
        'input': GetTrendingPlaylistsUseCaseInput(),
        'useCase': getTrendingPlaylistsUseCase,
      },
      {
        'input': GetTrendingSongsUseCaseInput(),
        'useCase': getTrendingSongsUseCase,
      },
    ];

    List<Result> results = [];

    for (final useCase in useCases) {
      final result =
          await useCase['useCase']!.execute(useCase['input']!) as Result;
      if (!result.hasValue()) {
        emit(TrendingsFailed(failure: result.failure!));
        return;
      } else {
        results.add(result);
      }
    }

    emit(TrendingsLoaded(
      // trendingArtists: results[0].value as List<Artist>,
      trendingAlbums: results[0].value as List<Album>,
      promotionalBanner: results[1].value as PromotionalBanner,
      trendingPlaylists: results[2].value as List<Playlist>,
      trendingSongs: results[3].value as List<Song>,
    ));
  }
}
