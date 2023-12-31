part of 'artist_detail_bloc.dart';

abstract class ArtistDetailState extends Equatable {
  final Failure? failure;
  const ArtistDetailState({this.failure});

  @override
  List<Object?> get props => [];
}

class ArtistDetailLoading extends ArtistDetailState {}

class ArtistDetailLoaded extends ArtistDetailState {
  final Artist artist;

  const ArtistDetailLoaded({required this.artist});

  @override
  List<Object?> get props => [artist];
}

class ArtistDetailFailed extends ArtistDetailState {
  const ArtistDetailFailed({required super.failure});
}
