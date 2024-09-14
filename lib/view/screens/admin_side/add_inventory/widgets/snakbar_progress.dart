import 'package:flutter/material.dart';
import 'package:godrive/core/colors.dart';

void showProgressSnackbar(
    BuildContext context, ValueNotifier<double> progressNotifier) {
  final snackBar = SnackBar(
    backgroundColor: green50,
    content: Row(
      children: [
        Expanded(
          child: ValueListenableBuilder<double>(
            valueListenable: progressNotifier,
            builder: (context, progress, child) {
              return LinearProgressIndicator(
                value: 60,
                backgroundColor: Colors.grey.shade300,
                color: Colors.blue,
              );
            },
          ),
        ),
        const SizedBox(width: 20),
        const Text('Uploading...'),
      ],
    ),
    duration: const Duration(hours: 1), // Keep it open until manually dismissed
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
