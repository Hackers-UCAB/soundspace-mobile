import 'package:flutter/material.dart';
import 'package:sign_in_bloc/application/BLoC/user/user_bloc.dart';

final List<String> genderOptions = ['', 'M', 'F', 'O'];

class GenderPickerField extends StatelessWidget {
  final UserProfileLoadedState state;
  final UserBloc userBloc;

  const GenderPickerField(
      {super.key, required this.state, required this.userBloc});

  @override
  Widget build(BuildContext context) {
    String selectedOption = state.user.genre ?? genderOptions[0];
    final bodySmall = Theme.of(context).textTheme.bodySmall;
    final size = MediaQuery.of(context).size;
    return Flexible(
      flex: 2,
      child: DropdownMenu<String>(
        label: Text(
          "Género",
          style: bodySmall!.copyWith(fontSize: size.width * 0.045),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide(width: 1, color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide:
                BorderSide(width: 1, color: Color.fromARGB(0, 85, 51, 51)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide(width: 2, color: Colors.white),
          ),
          fillColor: Color.fromARGB(82, 129, 118, 160),
          filled: true,
        ),
        enabled: state.editable,
        enableSearch: false,
        textStyle: bodySmall.copyWith(fontSize: size.width * 0.045),
        menuStyle: const MenuStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(
          Color.fromARGB(255, 129, 118, 160),
        )),
        initialSelection: state.user.genre,
        onSelected: (String? newValue) {
          if (newValue != null) {
            selectedOption = newValue;
            userBloc
                .add(GenreEditedEvent(user: state.user, genre: selectedOption));
          }
        },
        dropdownMenuEntries:
            genderOptions.map<DropdownMenuEntry<String>>((String value) {
          return DropdownMenuEntry<String>(value: value, label: value);
        }).toList(),
      ),
    );
  }
}
