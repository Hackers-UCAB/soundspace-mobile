// ignore_for_file: prefer_null_aware_operators
import 'package:sign_in_bloc/infrastructure/helpers/image_convertert.dart';
import '../../../domain/playlist/playlist.dart';
import '../song/song_mapper.dart';

class PlaylistMapper {
  static Playlist fromJson(Map<String, dynamic> json) {
    return Playlist(
      id: json['id'],
      name: json['name'],
      image: json['image'] != null
          ? ImageConverter.convert(json['image']['data'])
          : null,
      artistName: json['creators'] != null
          ? (json['creators'] as List<dynamic>)
              .map<String>((e) => e['creatorName'])
              .toList()
          : null,
      songs:
          json['songs'] != null ? SongMapper.fromJsonList(json['songs']) : null,
    );
  }

  static Map<String, dynamic> toJson(Playlist playlist) {
    return {
      'codigo_playlist': playlist.id,
      'nombre': playlist.name,
      'referencia_imagen': playlist.image,
    };
  }

  static List<Playlist> fromJsonList(dynamic jsonList) {
    return jsonList.map<Playlist>((json) => fromJson(json)).toList();
  }
}
