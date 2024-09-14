import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  const Heading({
    super.key,
    required this.heading,
  });
  final String heading;
  @override
  Widget build(BuildContext context) {
    return Text(
      heading,
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }
}