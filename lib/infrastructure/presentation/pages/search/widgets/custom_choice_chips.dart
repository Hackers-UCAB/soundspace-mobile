import 'dart:async';

import 'package:flutter/material.dart';
import '../../../../../application/BLoC/search/search_bloc.dart';

class CustomChoiceChips extends StatefulWidget {
  late final List<Map<String, dynamic>> choices;
  final SearchBloc searchBloc;

  CustomChoiceChips({super.key, required this.searchBloc}) {
    choices = [
      {'name': 'Artista', 'filter': 'artists'},
      {'name': 'Album', 'filter': 'albums'},
      {'name': 'Playlist', 'filter': 'playlists'},
      {'name': 'Song', 'filter': 'songs'}
    ];
  }

  @override
  State<CustomChoiceChips> createState() => _CustomChoiceChipsState();
}

class _CustomChoiceChipsState extends State<CustomChoiceChips> {
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.bodySmall;
    final List<Widget> chips = widget.choices
        .map<ChoiceChip>((Map<String, dynamic> choice) => ChoiceChip(
              label: Text(choice['name'],
                  style: widget.searchBloc.state.filter == choice['filter']
                      ? textTheme?.copyWith(color: Colors.black)
                      : textTheme),
              selected: widget.searchBloc.state.filter == choice['filter'],
              onSelected: (bool selected) {
                if (_debounce?.isActive ?? false) _debounce?.cancel();
                _debounce = Timer(const Duration(milliseconds: 500), () {
                  widget.searchBloc.add(SearchFilterChanged(
                      filter: selected ? choice['filter'] : ''));
                });
              },
              selectedColor: const Color.fromARGB(255, 255, 255, 255),
              backgroundColor: const Color.fromARGB(255, 20, 2, 45),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ))
        .toList();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Wrap(
        spacing: 5,
        alignment: WrapAlignment.center,
        children: chips,
      ),
    );
  }
}
