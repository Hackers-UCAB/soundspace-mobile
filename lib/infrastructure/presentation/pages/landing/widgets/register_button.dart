import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../config/router/app_router.dart';

class RegisterButtom extends StatefulWidget {
  const RegisterButtom({super.key});

  @override
  State<RegisterButtom> createState() => _RegisterButtomState();
}

class _RegisterButtomState extends State<RegisterButtom> {
  @override
  Widget build(BuildContext context) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    return ElevatedButton(
      onPressed: () {
        GetIt.instance.get<AppNavigator>().navigateTo('/logIn');
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        backgroundColor: const Color.fromARGB(255, 1, 229, 240),
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 18),
      ),
      child: Text(
        //TODO: Poner el text style en el theme
        'REGÍSTRATE AQUÍ',
        style: bodyMedium!
            .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}
