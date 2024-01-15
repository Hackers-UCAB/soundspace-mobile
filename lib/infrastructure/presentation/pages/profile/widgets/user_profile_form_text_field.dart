import 'package:flutter/material.dart';
import 'package:sign_in_bloc/application/BLoC/user/user_bloc.dart';

class UserProfileFormTextField extends StatelessWidget {
  final UserProfileLoadedState state;
  final UserBloc userBloc;
  final String? labelText;
  final String? initialValue;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  const UserProfileFormTextField(
      {super.key,
      required this.state,
      required this.userBloc,
      this.labelText,
      this.initialValue,
      required this.onChanged,
      this.validator});

  @override
  Widget build(BuildContext context) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final size = MediaQuery.of(context).size;
    return TextFormField(
      enabled: state.editable,
      validator: validator,
      initialValue: initialValue,
      onChanged: onChanged,
      style: bodyMedium!.copyWith(fontSize: size.width * 0.045),
      decoration: InputDecoration(
          hintStyle: bodyMedium!.copyWith(fontSize: size.width * 0.045),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              borderSide: BorderSide(width: 1, color: Colors.transparent)),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              borderSide:
                  BorderSide(width: 1, color: Color.fromARGB(0, 85, 51, 51))),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              borderSide: BorderSide(width: 2, color: Colors.white)),
          fillColor: const Color.fromARGB(82, 129, 118, 160),
          filled: true,
          labelText: labelText,
          labelStyle: bodyMedium!.copyWith(fontSize: size.width * 0.045)),
    );
  }
}
