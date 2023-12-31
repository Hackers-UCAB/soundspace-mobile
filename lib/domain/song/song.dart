class Song {
  final String id;
  final String name;
  final String duration;
  final List<int> image;
  final List<String>? artistsName;

  Song({
    required this.id,
    required this.name,
    required this.duration,
    required this.image,
    this.artistsName,
  });
}
