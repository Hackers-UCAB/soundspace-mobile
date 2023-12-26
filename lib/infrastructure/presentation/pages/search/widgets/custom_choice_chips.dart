import 'package:flutter/material.dart';

class CustomChoiceChips extends StatelessWidget {
  final List<String> choices;
  const CustomChoiceChips({super.key, required this.choices});

  @override
  Widget build(BuildContext context) {
    final List<Widget> chips = choices.map<ChoiceChip>((String choice) {
      return ChoiceChip(
        label: Text(choice, style: Theme.of(context).textTheme.bodySmall),
        selected: false,
        onSelected: (bool selected) {},
      );
    }).toList();

    return Wrap(
      spacing: 5,
      children: chips,
    );
  }
}
