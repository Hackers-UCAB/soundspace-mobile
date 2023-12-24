import 'package:flutter/material.dart';
import 'package:sign_in_bloc/domain/artist/artist.dart';

class ArtistInfo extends StatelessWidget {
  final Artist artist;

  const ArtistInfo({super.key, required this.artist});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          artist.imageURL,
          width: 200,
          height: 200,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 10),
        Text(
          artist.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
