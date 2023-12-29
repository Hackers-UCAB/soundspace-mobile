import 'package:sign_in_bloc/infrastructure/helpers/image_convertert.dart';

import '../../../domain/playlist/playlist.dart';

class PlaylistMapper {
  static Playlist fromJson(Map<String, dynamic> json) {
    return Playlist(
      id: json['codigo_playlist'],
      name: json['nombre'],
      image: ImageConverter.convert(json['referencia_imagen']),
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
