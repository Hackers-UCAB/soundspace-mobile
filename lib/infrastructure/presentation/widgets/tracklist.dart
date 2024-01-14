import 'dart:typed_data';
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
                child: Image.memory(
                  Uint8List.fromList(song.image!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: size.width * 0.4,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Text(
                  song.name,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: size.width * 0.04),
                ),
              ),
            ),
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    song.duration!,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: size.width * 0.035),
                  ), //duracion total de la cancion
                  const SizedBox(width: 5),
                  IconButton(
                    onPressed: () {
                      playerBloc.add(InitStream(
                          song.id,
                          10,
                          song.name,
                          Duration(
                              minutes: int.parse(song.duration!.split(':')[0]),
                              seconds:
                                  int.parse(song.duration!.split(':')[1]))));
                      //TODO: socket.sendIdSong(song.id);
                      // playerBloc.add(PlayingStartedEvent(song: song)),
                    },
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
