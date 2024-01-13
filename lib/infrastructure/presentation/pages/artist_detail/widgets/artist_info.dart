import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sign_in_bloc/domain/artist/artist.dart';

class ArtistInfo extends StatelessWidget {
  final Artist artist;

  const ArtistInfo({super.key, required this.artist});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.memory(
            Uint8List.fromList(artist.image!),
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              artist.name,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Genero',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              '${artist.albums?.length.toString()} Album${artist.albums!.length > 1 ? 's' : ''}',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${artist.songs?.length.toString()} Canci${artist.songs!.length > 1 ? 'ones' : 'ón'}',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
      ],
    );
  }
}
