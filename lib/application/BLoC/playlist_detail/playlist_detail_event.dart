part of 'playlist_detail_bloc.dart';

abstract class PlaylistDetailEvent {}

class FetchPlaylistDetailEvent extends PlaylistDetailEvent {
  final String playlistId;

  FetchPlaylistDetailEvent({required this.playlistId});
}
