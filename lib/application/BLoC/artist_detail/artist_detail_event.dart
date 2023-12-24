part of 'artist_detail_bloc.dart';

abstract class ArtistDetailEvent {}

class FetchArtistDetailEvent extends ArtistDetailEvent {
  final String artistId;

  FetchArtistDetailEvent({required this.artistId});
}
