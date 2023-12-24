import 'package:flutter/material.dart';

class AlbumHeader extends StatelessWidget {
  const AlbumHeader({super.key, required this.onBackPress});

  final VoidCallback onBackPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      width: double.infinity,
      color: Colors.transparent,
      height: 90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(0),
            iconSize: 25,
            onPressed: onBackPress,
          ),
        ],
      ),
    );
  }
}
