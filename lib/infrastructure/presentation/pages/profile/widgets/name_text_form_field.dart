import 'package:flutter/material.dart';
import 'package:sign_in_bloc/application/BLoC/user/user_bloc.dart';

class NameTextFormField extends StatelessWidget {
  final UserProfileLoadedState state;
  final UserBloc userBloc;

  const NameTextFormField(
      {super.key, required this.state, required this.userBloc});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: state.editable,
      initialValue: state.user.name,
      onChanged: (value) =>
          userBloc.add(NameEditedEvent(user: state.user, name: value)),
      style: const TextStyle(color: Colors.white),
      decoration: const InputDecoration(
          hintStyle: TextStyle(color: Color.fromARGB(146, 0, 0, 0)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              borderSide: BorderSide(width: 1, color: Colors.transparent)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              borderSide:
                  BorderSide(width: 1, color: Color.fromARGB(0, 85, 51, 51))),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              borderSide: BorderSide(width: 1, color: Colors.black)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              borderSide: BorderSide(width: 2, color: Colors.white)),
          fillColor: Color.fromARGB(82, 129, 118, 160),
          filled: true,
          labelText: 'Nombre y Apellido',
          labelStyle: TextStyle(color: Colors.white)),
    );
  }
}
