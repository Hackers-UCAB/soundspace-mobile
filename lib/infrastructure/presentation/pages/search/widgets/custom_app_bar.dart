import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final Color backgroundColor;
  final double elevation;
  final VoidCallback? onPressed;

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.onPressed,
    this.backgroundColor = Colors.transparent,
    this.elevation = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
          title,
          style: GoogleFonts.poppins().copyWith(
              color: Colors.white,
            )
        ),
      backgroundColor: backgroundColor,
      elevation: elevation,
      leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: onPressed,
              ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}