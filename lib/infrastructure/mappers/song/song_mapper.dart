import '../../../domain/song/song.dart';
import '../../helpers/image_convertert.dart';

class SongMapper {
  static Song fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'],
      name: json['name'],
      duration: json['duration'],
      image: ImageConverter.convert(json['image']),
      artistsName: json['artists'] ??
          json['artists'].map<String>((e) => e.name).toList(),
    );
  }

  static Map<String, dynamic> toJson(Song song) {
    return {
      'codigo_cancion': song.id,
      'nombre': song.name,
      'duracion': song.duration,
      'referencia_imagen': song.image,
    };
  }

  static List<Song> fromJsonList(dynamic jsonList) {
    return jsonList.map<Song>((json) => fromJson(json)).toList();
  }
}
