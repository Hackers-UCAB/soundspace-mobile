part of 'album_detail_bloc.dart';

abstract class AlbumDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AlbumDetailLoading extends AlbumDetailState {}

class AlbumDetailLoaded extends AlbumDetailState {
  final Album albumData;
  final List<Song> songsByAlbum;

  AlbumDetailLoaded({required this.albumData, required this.songsByAlbum});

  @override
  List<Object?> get props => [albumData, songsByAlbum];
}

class AlbumDetailFailed extends AlbumDetailState {
  final Failure failure;
  AlbumDetailFailed({required this.failure});
}
