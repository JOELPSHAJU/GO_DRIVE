import 'package:flutter/material.dart';

class SpecificationRow extends StatelessWidget {
  final String label;
  final String value;
  const SpecificationRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
        )
      ],
    );
  }
}
