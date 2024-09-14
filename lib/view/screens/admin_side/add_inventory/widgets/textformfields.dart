import 'package:flutter/material.dart';
import 'package:godrive/core/colors.dart';
import 'package:godrive/view/screens/universal_widgets/validators.dart';

class InputfieldsAddInventory extends StatelessWidget {
  const InputfieldsAddInventory({
    super.key,
    required this.modelnamecontroller,
    required this.hint, required this.inputType,
  });
  final TextInputType inputType;
  final TextEditingController modelnamecontroller;
  final String hint;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: inputType,
      validator: validateTextfield,
      controller: modelnamecontroller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(borderSide: BorderSide(color: black)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: black, width: 1.5)),
        hintText: hint,
      ),
    );
  }
}

class InputfieldsMinLine2 extends StatelessWidget {
  const InputfieldsMinLine2({
    super.key,
    required this.modelnamecontroller,
    required this.hint,
  });

  final TextEditingController modelnamecontroller;
  final String hint;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 1,
      maxLines: 5,
      validator: validateTextfield,
      controller: modelnamecontroller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(borderSide: BorderSide(color: black)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: black, width: 1.5)),
        hintText: hint,
      ),
    );
  }
}
