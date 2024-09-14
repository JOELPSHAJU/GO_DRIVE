import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:godrive/core/colors.dart';
import 'package:godrive/core/constants.dart';
import 'package:godrive/core/snakbars.dart';
import 'package:godrive/view/bloc/register_bloc/register_bloc.dart';
import 'package:godrive/view/screens/user_side/login_screen.dart/widgets/textformfield.dart';
import 'package:godrive/view/screens/universal_widgets/loading_button.dart';
import 'package:godrive/view/screens/universal_widgets/validators.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

final formKeyregister = GlobalKey<FormState>();
final _emailcontroller = TextEditingController();
final _passwordcontroller = TextEditingController();
final _confirmPasswordcontroller = TextEditingController();

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final registerbloc = context.read<RegisterBloc>();
    return Scaffold(
      backgroundColor: white,
      body: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            successSnakbar(context, 'Account created Successfully', green50);
            Navigator.pop(context);
          } else if (state is RegisterError) {
            failedSnakbar(context, state.error, red);
          }
        },
        builder: (context, state) {
          return SizedBox(
            width: size.width,
            height: size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  h40,
                  h20,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Hello! Register to ',
                              style: GoogleFonts.raleway(
                                  color: black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Get Started',
                              style: GoogleFonts.raleway(
                                  color: black,
                                  fontSize: 27,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        h20,
                        Form(
                          key: formKeyregister,
                          child: Column(
                            children: [
                              LoginTextformfield(
                                textInputType: TextInputType.emailAddress,
                                validator: validateEmail,
                                obsecure: false,
                                controller: _emailcontroller,
                                hintText: 'Enter your email',
                              ),
                              h20,
                              LoginTextformfield(
                                textInputType: TextInputType.name,
                                validator: validatePassword,
                                obsecure: true,
                                controller: _passwordcontroller,
                                hintText: 'Enter Password',
                              ),
                              h20,
                              LoginTextformfield(
                                textInputType: TextInputType.name,
                                validator: validatePassword,
                                obsecure: true,
                                controller: _confirmPasswordcontroller,
                                hintText: 'Conform password',
                              ),
                            ],
                          ),
                        ),
                        h20,
                        BlocBuilder<RegisterBloc, RegisterState>(
                          builder: (context, state) {
                            if (state is RegisterLoading) {
                              return loadingButton(
                                  media: size, onPressed: () {}, color: black);
                            }
                            return MaterialButton(
                                color: black,
                                minWidth: size.width,
                                height: 55,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                onPressed: () {
                                  if (formKeyregister.currentState!
                                      .validate()) {
                                    registerbloc.add(RegisterButtonClickEvent(
                                        email: _emailcontroller.text,
                                        password: _passwordcontroller.text));
                                  } else {
                                    warningSnakbar(
                                        context, 'Fill All Fields', red);
                                  }
                                },
                                child: const Text('Register',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: white,
                                        fontSize: 17)));
                          },
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                    registerbg,
                    width: size.width,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an Account?  ',
                        style: GoogleFonts.poppins(
                          color: darkgrey,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Login',
                            style: GoogleFonts.poppins(
                              color: black,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
