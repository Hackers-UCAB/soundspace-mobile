import '../song/song.dart';

class Playlist {
  final String id;
  final String? name;
  final List<int> image;
  final List<String>? artistName;
  final List<Song>? songs;

  Playlist({
    required this.id,
    this.name,
    required this.image,
    this.artistName,
    this.songs,
  });
}
