import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? errorMessage;
  final bool obscureText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final IconData? icon;
  final TextEditingController? controller;

  const CustomTextFormField({
    super.key,
    this.label,
    this.hint,
    this.errorMessage,
    this.obscureText = false,
    this.onChanged,
    this.validator,
    this.icon,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: const BorderSide(color: Color.fromARGB(0, 255, 255, 255)),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: TextFormField(
        controller: controller,
        style: Theme.of(context).textTheme.bodySmall,
        onChanged: onChanged,
        validator: validator,
        obscureText: obscureText,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          fillColor: const Color.fromARGB(69, 238, 238, 238),
          filled: true,
          enabledBorder: border,
          focusedBorder: border,
          errorBorder: border.copyWith(
              borderSide: BorderSide(color: Colors.red.shade800)),
          focusedErrorBorder: border.copyWith(
              borderSide: BorderSide(color: Colors.red.shade800)),
          errorStyle: const TextStyle(fontSize: 15),
          //isDense: true,
          //label: label != null ? Text(label!) : null,
          hintText: hint,
          hintStyle: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          errorText: errorMessage,
          focusColor: Colors.white,
          suffixIcon: icon != null ? Icon(icon, color: Colors.white) : null,
          // icon: Icon( Icons.supervised_user_circle_outlined, color: colors.primary, )
        ),
      ),
    );
  }
}
