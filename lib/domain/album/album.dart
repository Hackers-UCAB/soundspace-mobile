import '../song/song.dart';

class Album {
  final String id;
  final String? name;
  final List<int>? image;
  final List<String>? artistName;
  final List<Song>? songs;
  final String? duration;

  Album({
    required this.id,
    this.name,
    this.image,
    this.artistName,
    this.songs,
    this.duration,
  });
}
