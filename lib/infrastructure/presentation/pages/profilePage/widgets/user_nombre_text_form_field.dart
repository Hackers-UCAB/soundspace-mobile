import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/user/user_bloc.dart';

class NombreTextFormField extends StatelessWidget {
  final UserState? state;

  const NombreTextFormField({super.key, this.state});

  @override
  Widget build(BuildContext context) {
    final userBloc = GetIt.instance.get<UserBloc>();
    return TextFormField(
      enabled: state?.editable,
      initialValue: state?.name,
      onChanged: (value) => userBloc.add(NameEditedEvent(name: value)),
      style: TextStyle(color: Colors.white),
      decoration: const InputDecoration(
          hintText: 'Carlos Alonso',
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
