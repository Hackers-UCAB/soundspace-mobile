import 'package:sign_in_bloc/infrastructure/mappers/song/song_mapper.dart';

import '../../../domain/artist/artist.dart';
import '../album/album_mapper.dart';

class ArtistMapper {
  static Artist fromJson(Map<String, dynamic> json) {
    return Artist(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      albums: json['albums'] ?? AlbumMapper.fromJsonList(json['albums']),
      songs: json['songs'] ?? SongMapper.fromJsonList(json['songs']),
    );
  }

  static Map<String, dynamic> toJson(Artist artist) {
    return {
      'codigo_artista': artist.id,
      'nombre_artista': artist.name,
      'referencia_imagen': artist.image,
    };
  }

  static List<Artist> fromJsonList(dynamic jsonList) {
    return jsonList.map<Artist>((json) => fromJson(json)).toList();
  }
}
