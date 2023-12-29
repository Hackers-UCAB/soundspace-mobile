import 'package:sign_in_bloc/infrastructure/helpers/image_convertert.dart';
import '../../../domain/album/album.dart';

class AlbumMapper {
  static Album fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['codigo_playlist'],
      name: json['nombre'],
      image: ImageConverter.convert(json['referencia_imagen']),
    );
  }

  static Map<String, dynamic> toJson(Album album) {
    return {
      'codigo_playlist': album.id,
      'nombre': album.name,
      'referencia_imagen': album.image,
    };
  }

  static List<Album> fromJsonList(dynamic jsonList) {
    return jsonList.map<Album>((json) => fromJson(json)).toList();
  }
}
