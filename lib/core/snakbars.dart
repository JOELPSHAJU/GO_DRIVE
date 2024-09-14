import 'package:flutter/material.dart';
import 'package:godrive/core/colors.dart';

void customSnackbar(context, message, color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      elevation: 0,
      content: Text(
        message,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
      backgroundColor: color,
      duration: const Duration(milliseconds: 1200),
    ),
  );
}

void successSnakbar(context, message, color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      elevation: 3,
      content: Column(
        children: [
          const Text(
            'Success',
            style: TextStyle(
              fontSize: 18,
              color: white,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            message,
            style: const TextStyle(
              fontSize: 15,
              color: white,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      backgroundColor: green50,
      duration: const Duration(milliseconds: 1500),
    ),
  );
}

void failedSnakbar(context, message, color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      elevation: 3,
      content: Column(
        children: [
          const Text(
            'Error',
            style: TextStyle(
              fontSize: 18,
              color: white,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            message,
            style: const TextStyle(
              fontSize: 15,
              color: white,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      backgroundColor: red,
      duration: const Duration(milliseconds: 1500),
    ),
  );
}

void warningSnakbar(context, message, color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      elevation: 7,
      content: Column(
        children: [
          const Text(
            'Warning',
            style: TextStyle(
              fontSize: 18,
              color: white,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            message,
            style: const TextStyle(
              fontSize: 15,
              color: white,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 199, 182, 33),
      duration: const Duration(milliseconds: 1500),
    ),
  );
}
