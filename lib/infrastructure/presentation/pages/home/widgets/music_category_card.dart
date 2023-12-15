import 'package:flutter/material.dart';

class MusicCategoryCard extends StatelessWidget {
  final String name; //model
  final Color color;
  //final String imgPath; model

  const MusicCategoryCard({super.key, required this.name, required this.color});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {}, //redireccionar
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            color: color,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ]),
        width: size.width * 0.45, //cambiar por MediaQuery
        height: size.width * 0.26, //cambiar por MediaQuery
        child: Stack(
          children: [
            //imagen
            SizedBox(
              width: 150,
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8),
                  child:
                      Text(name, style: Theme.of(context).textTheme.bodyLarge),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
