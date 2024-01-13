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
    return Flexible(
      flex: 2,
      child: DropdownMenu<String>(
        label: const Text(
          "Género",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide(width: 1, color: Colors.transparent),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide:
                BorderSide(width: 1, color: Color.fromARGB(0, 85, 51, 51)),
          ),
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide(width: 1, color: Colors.black),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide(width: 2, color: Colors.white),
          ),
          constraints: BoxConstraints.loose(Size.fromWidth(200)),
          fillColor: Color.fromARGB(82, 129, 118, 160),
          filled: true,
        ),
        enabled: state.editable,
        enableSearch: false,
        textStyle: const TextStyle(color: Colors.white, fontSize: 17),
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
