part of 'trendings_bloc.dart';

abstract class TrendingsState extends Equatable {
  final Failure? failure;
  const TrendingsState({this.failure});

  @override
  List<Object?> get props => [];
}

class TrendingsLoading extends TrendingsState {}

class TrendingsLoaded extends TrendingsState {
  // final List<Artist> trendingArtists;
  // final List<Album> trendingAlbums;
  final PromotionalBanner promotionalBanner;
  // final List<Playlist> trendingPlaylists;
  // final List<Song> trendingSongs;

  const TrendingsLoaded({
    // required this.trendingArtists,
    // required this.trendingAlbums,
    required this.promotionalBanner,
    // required this.trendingPlaylists,
    // required this.trendingSongs,
  });

  @override
  List<Object?> get props => [
        // trendingArtists,
        // trendingAlbums,
        promotionalBanner,
        // trendingPlaylists,
        // trendingSongs,
      ];
}

class TrendingsFailed extends TrendingsState {
  const TrendingsFailed({required super.failure});
}
