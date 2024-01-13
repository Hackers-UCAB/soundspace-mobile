import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sign_in_bloc/application/BLoC/user/user_bloc.dart';

class DatePickerField extends StatelessWidget {
  final UserProfileLoadedState state;
  final UserBloc userBloc;

  const DatePickerField(
      {super.key, required this.state, required this.userBloc});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 3,
      //TODO: Separar en otro widget - Jorge
      // FECHA DE NACIMIENTO
      child: TextFormField(
        enabled: state.editable,
        controller: TextEditingController(
            text: state.user.birthdate == null
                ? null
                : DateFormat('dd/MM/yyyy').format(state.user.birthdate!)),
        readOnly: true,
        onTap: () {
          showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          ).then((value) {
            if (value != null) {
              userBloc.add(FechaEditedEvent(user: state.user, fecha: value));
            }
          });
        },
        style: const TextStyle(color: Colors.white, fontSize: 17),
        decoration: const InputDecoration(
          hintText: 'DD/MM/YYYY',
          hintStyle: TextStyle(color: Color.fromARGB(146, 0, 0, 0)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide(width: 1, color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide:
                BorderSide(width: 1, color: Color.fromARGB(0, 85, 51, 51)),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide(width: 1, color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide(width: 2, color: Colors.white),
          ),
          fillColor: Color.fromARGB(82, 129, 118, 160),
          filled: true,
          labelText: 'Fecha de Nacimiento',
          labelStyle: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
