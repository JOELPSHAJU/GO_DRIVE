// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RowSearch extends StatelessWidget {
  final String image;
  final String last;
  final String Texts;
  const RowSearch(
      {super.key,
      required this.image,
      required this.last,
      required this.Texts});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(
          // ignore: unnecessary_string_interpolations
          '$image',
          color: Colors.black,
          width: 28,
        ),
        Text(
          '${Texts.toString().toUpperCase()} $last',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
