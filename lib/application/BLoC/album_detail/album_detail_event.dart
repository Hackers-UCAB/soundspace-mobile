part of 'album_detail_bloc.dart';

abstract class AlbumDetailEvent {}

class FetchAlbumDetailEvent extends AlbumDetailEvent {
  final String albumId;

  FetchAlbumDetailEvent({required this.albumId});
}
