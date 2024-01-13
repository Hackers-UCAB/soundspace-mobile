import 'package:flutter/material.dart';
import 'package:sign_in_bloc/domain/song/song.dart';
import '../../../../../domain/album/album.dart';

class Info extends StatelessWidget {
  final String? name;
  final List<String>? artistName;
  final List<Song>? songs;

  const Info(
      {super.key,
      required this.name,
      required this.artistName,
      required this.songs});

  @override
  Widget build(BuildContext context) {
    Duration totalDuration = Duration.zero;
    songs?.forEach(((element) {
      var list = element.duration!.split(':');
      totalDuration = totalDuration +
          Duration(minutes: int.parse(list[0]), seconds: int.parse(list[1]));
    }));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name!,
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                artistName == null ? '' : artistName.toString(),
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${songs?.length.toString()} CANCION${songs!.length > 1 ? 'ES' : ''}',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.watch_later_outlined,
                    color: Colors.white,
                  ),
                  Text(
                    ' ${totalDuration.inMinutes} MIN',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
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
