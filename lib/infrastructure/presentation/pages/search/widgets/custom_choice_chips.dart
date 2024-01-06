import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../../../application/BLoC/search/search_bloc.dart';

class CustomChoiceChips extends StatefulWidget {
  late final List<String> choices;

  CustomChoiceChips({super.key}) {
    choices = ['Artista', 'Album', 'Playlist', 'Song'];
  }

  @override
  State<CustomChoiceChips> createState() => _CustomChoiceChipsState();
}

class _CustomChoiceChipsState extends State<CustomChoiceChips> {
  Timer? _debounce;

  String? _lastFilter;

  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.instance;
    final searchBloc = getIt.get<SearchBloc>();
    final textTheme = Theme.of(context).textTheme.bodySmall;
    final List<Widget> chips = widget.choices
        .map<ChoiceChip>((String choice) => ChoiceChip(
              label: Text(choice,
                  style: searchBloc.state.filter.contains(choice)
                      ? textTheme?.copyWith(color: Colors.black)
                      : textTheme),
              selected: searchBloc.state.filter.contains(choice),
              onSelected: (bool selected) {
                if (_debounce?.isActive ?? false) _debounce?.cancel();
                _lastFilter = _mapChoiceToFilter(choice);
                _debounce = Timer(const Duration(milliseconds: 500), () {
                  final getIt = GetIt.instance;
                  final searchBloc = getIt.get<SearchBloc>();
                  searchBloc.add(SearchFilterChanged(filter: _lastFilter!));
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

  String _mapChoiceToFilter(String choice) {
    switch (choice) {
      case 'Artista':
        return 'artist';
      case 'Album':
        return 'album';
      case 'Playlist':
        return 'playlist';
      case 'Song':
        return 'song';
      default:
        return '';
    }
  }
}
