part of 'artist_detail_bloc.dart';

abstract class ArtistDetailEvent {}

class FetchArtistDetailEvent extends ArtistDetailEvent {
  final Artist artist;

  FetchArtistDetailEvent({required this.artist});
}
