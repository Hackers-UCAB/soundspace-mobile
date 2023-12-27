import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../../application/BLoC/search/search_bloc.dart';

class CustomChoiceChips extends StatelessWidget {
  late final List<String> choices;

  CustomChoiceChips({super.key}) {
    choices = ['Artista', 'Album', 'Playlist', 'Song', 'Podcast'];
  }

  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.instance;
    final searchBloc = getIt.get<SearchBloc>();
    final textTheme = Theme.of(context).textTheme.bodySmall;
    final List<Widget> chips = choices
        .map<ChoiceChip>((String choice) => ChoiceChip(
              label: Text(choice,
                  style: choice == searchBloc.state.filter
                      ? textTheme?.copyWith(color: Colors.black)
                      : textTheme),
              selected: choice == searchBloc.state.filter,
              onSelected: (bool selected) {
                if (selected) {
                  searchBloc.add(SearchFilterChanged(filter: choice));
                } else {
                  searchBloc.add(SearchFilterChanged(filter: ''));
                }
              },
              selectedColor: const Color.fromARGB(255, 255, 255, 255),
              backgroundColor: const Color.fromARGB(255, 20, 2, 45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
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
