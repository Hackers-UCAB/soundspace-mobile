part of 'playlist_detail_bloc.dart';

abstract class PlaylistDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class PlaylistDetailLoading extends PlaylistDetailState {}

class PlaylistDetailLoaded extends PlaylistDetailState {
  final Playlist playlist;
  PlaylistDetailLoaded({required this.playlist});

  @override
  List<Object> get props => [playlist];
}

class PlaylistDetailFailed extends PlaylistDetailState {
  final Failure failure;
  PlaylistDetailFailed({required this.failure});
}
