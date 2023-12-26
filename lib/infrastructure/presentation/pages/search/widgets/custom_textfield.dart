import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatelessWidget {
  final String? label;
  final String? hint;
  final bool obscureText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final IconData? icon;

  const CustomTextFormField({
    super.key,
    this.label,
    this.hint,
    this.obscureText = false,
    this.onChanged,
    this.validator,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: const BorderSide(color: Color.fromARGB(0, 255, 255, 255)),
    );
    final background = BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF372F47),
          Color(0xFF462F64),
          Color(0xFF462F64),
          ],
      ),
    );

    return Container(
      decoration: background,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: TextFormField(
          style: GoogleFonts.poppins().copyWith(
            color: Colors.white,
          ),
          onChanged: onChanged,
          validator: validator,
          obscureText: obscureText,
          cursorColor: Colors.white,
          decoration: InputDecoration(
            filled: false,
            enabledBorder: border,
            focusedBorder: border,
            errorStyle: const TextStyle(fontSize: 15),
            //isDense: true,
            //label: label != null ? Text(label!) : null,
            hintText: hint,
            hintStyle: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
            suffixIcon: icon != null ? Icon(icon, color: Colors.white) : null,
            // icon: Icon( Icons.supervised_user_circle_outlined, color: colors.primary, )
          ),
        ),
      ),
    );
  }
}