import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginTextformfield extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obsecure;
  final TextInputType textInputType;
  final String? Function(String?)? validator;


   const LoginTextformfield({
    super.key,
    required this.controller,
    required this.hintText,
    this.obsecure = false, required this.textInputType, required this.validator,
  });

  @override
  State<LoginTextformfield> createState() => _LoginTextformfieldState();
}

class _LoginTextformfieldState extends State<LoginTextformfield> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obsecure;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      cursorColor: const Color.fromARGB(255, 0, 0, 0),
      cursorWidth: 1,
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.w500,
        color: const Color.fromARGB(255, 0, 0, 0),
      ),
      controller: widget.controller,
      validator:widget.validator,
      obscureText: _isObscured,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(255, 233, 233, 233),
        hintText: widget.hintText,
        hintStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w300,
          color: const Color.fromARGB(255, 74, 74, 74),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
        border: InputBorder.none,
        suffixIcon: widget.obsecure
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
                icon: Icon(
                  _isObscured
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                ),
              )
            : null,
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
