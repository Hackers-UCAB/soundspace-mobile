import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sign_in_bloc/domain/artist/artist.dart';

class ArtistInfo extends StatelessWidget {
  final Artist artist;

  const ArtistInfo({super.key, required this.artist});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.memory(
            Uint8List.fromList(artist.image!),
            width: size.width * 0.5,
            height: size.width * 0.5,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          width: size.width * 0.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 80,
                child: Flexible(
                  child: Text(artist.name,
                      style: bodyMedium!.copyWith(fontSize: size.width * 0.07)),
                ),
              ),
              Text(
                'Genero',
                style: bodyMedium.copyWith(fontSize: size.width * 0.05),
              ),
              const SizedBox(height: 20),
              Text(
                  '${artist.albums?.length.toString()} Album${artist.albums!.length > 1 ? 's' : ''}',
                  style: bodyMedium.copyWith(
                      fontSize: size.width * 0.04,
                      fontWeight: FontWeight.bold)),
              Text(
                  '${artist.songs?.length.toString()} Canci${artist.songs!.length > 1 ? 'ones' : 'ón'}',
                  style: bodyMedium.copyWith(
                      fontSize: size.width * 0.04,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        )
      ],
    );
  }
}
