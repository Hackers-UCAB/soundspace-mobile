import '../album/album.dart';
import '../song/song.dart';

class Artist {
  final String id;
  final String name;
  final List<int>? image;
  final List<Album>? albums;
  final List<Song>? songs;

  Artist(
      {required this.id,
      required this.name,
      this.image,
      this.albums,
      this.songs});
}
