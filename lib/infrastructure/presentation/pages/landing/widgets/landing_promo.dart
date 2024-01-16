import 'package:flutter/material.dart';

class LandingPromo extends StatelessWidget {
  final String promoPath;

  const LandingPromo({super.key, required this.promoPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      width: MediaQuery.of(context).size.width,
      foregroundDecoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.5, 0.8, 0.85, 0.95],
        colors: <Color>[
          Colors.transparent,
          Color.fromARGB(100, 46, 21, 90),
          Color.fromARGB(150, 29, 21, 72),
          Color.fromARGB(255, 34, 21, 59),
        ],
      )),
      child: Image.asset(
        promoPath,
        fit: BoxFit.fill,
      ),
    );
  }
}
