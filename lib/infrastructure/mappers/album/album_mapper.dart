// ignore_for_file: prefer_null_aware_operators

import 'package:sign_in_bloc/infrastructure/helpers/image_convertert.dart';
import 'package:sign_in_bloc/infrastructure/mappers/song/song_mapper.dart';
import '../../../domain/album/album.dart';

class AlbumMapper {
  static Album fromJson(Map<String, dynamic> json) {
    return Album(
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
      duration: json['duration'],
      songs: json['songs'] != null
          ? SongMapper.fromJsonList(json['songs'])
          : null, //TODO: Ver que esta shit funcione
    );
  }

  static Map<String, dynamic> toJson(Album album) {
    //TODO:Arreglar esto
    return {
      'id': album.id,
      'name': album.name,
      'image': album.image,
    };
  }

  static List<Album> fromJsonList(dynamic jsonList) {
    return jsonList.map<Album>((json) => fromJson(json)).toList();
  }
}
