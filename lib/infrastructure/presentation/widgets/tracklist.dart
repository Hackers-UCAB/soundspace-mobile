import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../application/BLoC/player/player_bloc.dart';
import '../../../domain/song/song.dart';

class Tracklist extends StatelessWidget {
  final List<Song> songs;

  const Tracklist({super.key, required this.songs});

  @override
  Widget build(BuildContext context) {
    final List<_TracklistItem> tracklist = songs
        .map((song) => _TracklistItem(
              song: song,
            ))
        .toList();

    return Column(
      children: tracklist,
    );
  }
}

class _TracklistItem extends StatelessWidget {
  final Song song;
  final playerBloc = GetIt.instance.get<PlayerBloc>();

  _TracklistItem({required this.song});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 9, right: 9),
      child: Card(
        elevation: 2.0,
        color: const Color.fromARGB(33, 255, 255, 255),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: SizedBox(
                //imagen
                width: size.width * 0.2,
                height: size.width * 0.2,

                child: Image.network(
                  song.imageURL,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(children: [
                Text(
                  song.name,
                ), //song.artist
              ]),
            ),
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(song.duration), //duracion total de la cancion
                  const SizedBox(width: 6),
                  IconButton(
                    onPressed: () =>
                        playerBloc.add(PlayingStartedEvent(song: song)),
                    icon: const Icon(
                      Icons.play_arrow_sharp,
                      color: Color(0xff1de1ee),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
