import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/user/user_bloc.dart';

class EmailTextFormField extends StatelessWidget {
  final UserState? state;

  const EmailTextFormField({super.key, this.state});

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }

  @override
  Widget build(BuildContext context) {
    final userBloc = GetIt.instance.get<UserBloc>();
    return TextFormField(
      validator: validateEmail,
      enabled: state?.editable,
      initialValue: state?.email,
      onChanged: (value) => userBloc.add(EmailEditedEvent(email: value)),
      style: TextStyle(color: Colors.white),
      decoration: const InputDecoration(
          hintText: 'CarlosAlonso@CarlosAlonso.Com',
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
          labelText: 'Correo Electrónico',
          labelStyle: TextStyle(color: Colors.white)),
    );
  }
}
