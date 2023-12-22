part of 'artist_detail_bloc.dart';

abstract class ArtistDetailState extends Equatable {
  final Failure? failure;
  const ArtistDetailState({this.failure});

  @override
  List<Object?> get props => [];
}

class ArtistDetailLoading extends ArtistDetailState {}

class ArtistDetailLoaded extends ArtistDetailState {
  final Artist artistData;
  final List<Album> artistAlbums;
  final List<Song> artistAlbumSongs;

  const ArtistDetailLoaded(
      {required this.artistData,
      required this.artistAlbums,
      required this.artistAlbumSongs});

  @override
  List<Object?> get props => [artistData, artistAlbums, artistAlbumSongs];
}

class ArtistDetailFailed extends ArtistDetailState {
  const ArtistDetailFailed({required super.failure});
}
