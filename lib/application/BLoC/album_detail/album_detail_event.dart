part of 'album_detail_bloc.dart';

abstract class AlbumDetailEvent {}

class FetchAlbumDetailEvent extends AlbumDetailEvent {
  final Album album;

  FetchAlbumDetailEvent({required this.album});
}
