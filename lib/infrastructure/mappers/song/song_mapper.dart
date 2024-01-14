// ignore_for_file: prefer_null_aware_operators

import '../../../domain/song/song.dart';
import '../../helpers/image_convertert.dart';

class SongMapper {
  static Song fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'],
      name: json['name'],
      duration:
          json['duration'] != null ? formatDuration(json['duration']) : null,
      image: json['image'] != null
          ? ImageConverter.convert(json['image']['data'])
          : null,
      artistsName: json['artists'] != null
          ? (json['artists'] as List).map<String>((e) => e['name']).toList()
          : null,
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

  static String formatDuration(String duration) {
    String newDuration =
        duration.split(':').map((part) => part == '00' ? '' : part).join(':');

    if (newDuration.startsWith(':')) {
      newDuration = newDuration.substring(1);
    }

    return newDuration;
  }
}
