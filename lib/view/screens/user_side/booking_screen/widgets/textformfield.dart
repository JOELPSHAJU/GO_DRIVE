import 'package:flutter/material.dart';
import 'package:godrive/core/colors.dart';

class TextformfieldProject extends StatelessWidget {
  const TextformfieldProject({
    super.key,
    required this.phonenumberController,
    required this.hint,
    this.validator,
    required this.type,
  });

  final TextEditingController phonenumberController;
  final String hint;
  final validator;
  final TextInputType type;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      style: const TextStyle(fontWeight: FontWeight.w500),
      controller: phonenumberController,
      keyboardType: type,
      decoration: InputDecoration(
        hintText: hint,
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: black, width: 1.5),
            borderRadius: BorderRadius.circular(10)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: black, width: 1)),
      ),
    );
  }
}
