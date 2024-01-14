import '../song/song.dart';

class Playlist {
  final String id;
  final String? name;
  final List<int>? image;
  final List<String>? artistName;
  final List<Song>? songs;
  final String? duration;

  Playlist({
    required this.id,
    this.name,
    this.image,
    this.artistName,
    this.songs,
    this.duration,
  });
}
