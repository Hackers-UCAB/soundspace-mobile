import 'package:flutter/material.dart';

abstract class Background extends StatelessWidget {
  const Background({super.key});

  Widget child(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        _GradientBackground(),
        child(context),
      ]),
    );
  }
}

class _GradientBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: <Color>[
            Color.fromARGB(255, 52, 13, 131),
            Color.fromARGB(255, 30, 8, 58),
            Color.fromARGB(255, 24, 18, 31),
            Color.fromARGB(255, 30, 8, 58),
            Color.fromARGB(255, 57, 13, 145),
          ],
        ),
      ),
    );
  }
}
