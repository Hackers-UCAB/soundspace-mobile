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
    final bodySmall = Theme.of(context).textTheme.bodySmall;
    final size = MediaQuery.of(context).size;
    return Flexible(
      flex: 3,
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
            initialEntryMode: DatePickerEntryMode.calendarOnly,
          ).then((value) {
            if (value != null) {
              userBloc.add(FechaEditedEvent(user: state.user, fecha: value));
            }
          });
        },
        style: bodySmall!.copyWith(fontSize: size.width * 0.045),
        decoration: InputDecoration(
          hintText: 'DD/MM/YYYY',
          hintStyle: bodySmall.copyWith(fontSize: size.width * 0.045),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide(width: 1, color: Colors.transparent),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide:
                BorderSide(width: 1, color: Color.fromARGB(0, 85, 51, 51)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide(width: 2, color: Colors.white),
          ),
          fillColor: const Color.fromARGB(82, 129, 118, 160),
          filled: true,
          labelText: 'Fecha de Nacimiento',
          labelStyle: bodySmall.copyWith(fontSize: size.width * 0.045),
        ),
      ),
    );
  }
}
