import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final String imagePath;
  final Function()? onTap;

  const ImageContainer(
      {super.key, required this.imagePath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: MediaQuery.of(context).size.width * 0.90,
      height: MediaQuery.of(context).size.width * 0.23,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(76, 255, 255, 255),
            Color.fromARGB(76, 255, 255, 255),
          ],
        ),
      ),
      child: ElevatedButton.icon(
          onPressed: onTap,
          icon: Image.asset(imagePath, width: size.width * 0.7),
          label: const Text(''),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors
                .transparent, // Establece el color de fondo como transparente,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          )),
    );
  }
}
