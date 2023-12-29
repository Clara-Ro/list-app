import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  const InputWidget({
    super.key,
    this.focusNode,
    this.onChanged,
    this.textController,
    this.validator,
    this.prefixIcon,
    this.obscureText = false,
    this.hintText
  });

  final TextEditingController? textController;
  final FocusNode? focusNode;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final bool obscureText;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      focusNode: focusNode,
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        prefixIcon: prefixIcon,
        prefixIconColor: Colors.black,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.black)
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.black)
        ),
        labelStyle: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}