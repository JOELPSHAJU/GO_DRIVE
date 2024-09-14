import 'package:flutter/material.dart';
import 'package:godrive/core/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (c) => const ForgetPassword()));
          },
          child: Text(
            'Forgot password?',
            style:
                GoogleFonts.poppins(color: black, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
