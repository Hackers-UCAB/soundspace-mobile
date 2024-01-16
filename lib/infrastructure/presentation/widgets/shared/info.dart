import 'package:flutter/material.dart';
import 'package:sign_in_bloc/domain/song/song.dart';

class Info extends StatelessWidget {
  final String name;
  final List<String>? artistName;
  final List<Song> songs;
  final String duration;

  const Info(
      {super.key,
      required this.name,
      required this.artistName,
      required this.songs,
      required this.duration});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: bodyMedium!.copyWith(fontSize: size.width * 0.08),
              ),
              const SizedBox(height: 5),
              if (artistName != null)
                Text(
                  artistName!.join(', '),
                  style: bodyMedium.copyWith(fontSize: size.width * 0.04),
                ),
              const SizedBox(height: 5),
              Text(
                '${songs.length.toString()} cancion${songs.length > 1 ? 'es' : ''}',
                style: bodyMedium.copyWith(fontSize: size.width * 0.04),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Icon(
                    Icons.watch_later_outlined,
                    color: Colors.white,
                  ),
                  Text(
                    ' $duration min${duration.startsWith('0') || duration.startsWith('1') ? '' : 's'}',
                    style: bodyMedium.copyWith(fontSize: size.width * 0.04),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
