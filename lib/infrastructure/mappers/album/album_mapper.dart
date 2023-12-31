import 'package:sign_in_bloc/infrastructure/helpers/image_convertert.dart';
import 'package:sign_in_bloc/infrastructure/mappers/song/song_mapper.dart';
import '../../../domain/album/album.dart';

class AlbumMapper {
  static Album fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      name: json['name'] ?? json['name'],
      image: ImageConverter.convert(json['image']),
      artistName: json['creators'] ??
          json['creators'].map<String>((e) => e['creatorName']).toList(),
      songs: json['songs'] ??
          SongMapper.fromJsonList(
              json['songs']), //TODO: Ver que esta shit funcione
    );
  }

  static Map<String, dynamic> toJson(Album album) {
    //TODO:Arreglar esto
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
