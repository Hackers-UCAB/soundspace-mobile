import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/player/player_bloc.dart';

import '../../../../../domain/song/song.dart';

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
        child: Container(
          color: const Color.fromARGB(33, 255, 255, 255),
          child: Row(
            children: [
              Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        width: size.width * 0.90,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    //TODO: socket.sendIdSong(song.id);
                                    // playerBloc.add(PlayingStartedEvent(song: song)),
                                  },
                                  icon: const Icon(
                                    Icons.play_arrow_sharp,
                                    color: Color(0xff1de1ee),
                                  ),
                                ),
                                Text(song.name)
                              ],
                            ),

                            Text(song.duration!), //duracion total de la can
                          ],
                        ),
                      )),
                  Container(
                    width: size.width * 0.95,
                    height: 2,
                    color: Colors.white24,
                  )
                ],
              )
            ],
          ),
        ));
  }
}
