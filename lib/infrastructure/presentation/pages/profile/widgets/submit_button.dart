import 'package:flutter/material.dart';
import 'package:sign_in_bloc/application/BLoC/user/user_bloc.dart';

class SubmitButton extends StatelessWidget {
  final UserProfileLoadedState state;
  final UserBloc userBloc;

  const SubmitButton({
    super.key,
    required this.state,
    required this.userBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Visibility(
            visible: state.editable,
            child: ElevatedButton(
              onPressed: () {
                userBloc.add(SubmitChangesEvent(user: state.user));
              },
              style: const ButtonStyle(
                minimumSize: MaterialStatePropertyAll<Size>(Size(1, 50)),
                shape: MaterialStatePropertyAll<OutlinedBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)))),
                backgroundColor: MaterialStatePropertyAll<Color>(
                    Color.fromARGB(255, 7, 212, 239)),
                foregroundColor: MaterialStatePropertyAll<Color>(Colors.white),
              ),
              child: const Text(
                'Guardar',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            )));
  }
}
