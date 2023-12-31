part of 'album_detail_bloc.dart';

abstract class AlbumDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AlbumDetailLoading extends AlbumDetailState {}

class AlbumDetailLoaded extends AlbumDetailState {
  final Album album;

  AlbumDetailLoaded({required this.album});

  @override
  List<Object?> get props => [album];
}

class AlbumDetailFailed extends AlbumDetailState {
  final Failure failure;
  AlbumDetailFailed({required this.failure});
}
