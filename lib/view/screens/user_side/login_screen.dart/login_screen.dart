import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:godrive/core/colors.dart';
import 'package:godrive/core/constants.dart';
import 'package:godrive/core/snakbars.dart';
import 'package:godrive/view/bloc/login_bloc/login_bloc.dart';
import 'package:godrive/view/screens/admin_side/home_page/admin_home_page.dart';
import 'package:godrive/view/screens/user_side/login_screen.dart/widgets/forgetpassword_button.dart';
import 'package:godrive/view/screens/user_side/login_screen.dart/widgets/textformfield.dart';
import 'package:godrive/view/screens/user_side/main_screen/main_screen.dart';
import 'package:godrive/view/screens/user_side/register_screen/register_screen.dart';
import 'package:godrive/view/screens/universal_widgets/loading_button.dart';
import 'package:godrive/view/screens/universal_widgets/validators.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final formKey = GlobalKey<FormState>();
final _emailcontroller = TextEditingController();
final _passwordcontroller = TextEditingController();

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final loginbloc = context.read<LoginBloc>();
    final Size size = MediaQuery.of(context).size;
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          _emailcontroller.clear();
          _passwordcontroller.clear();
          Navigator.pushReplacement(
              context, CupertinoPageRoute(builder: (c) => MainScreen()));
        } else if (state is LoginError) {
          failedSnakbar(context, state.error, red);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: white,
          body: SizedBox(
            width: size.width,
            height: size.height,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * .16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome back! Glad',
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
                              'to see you, Again!',
                              style: GoogleFonts.raleway(
                                  color: black,
                                  fontSize: 27,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        h20,
                        Form(
                          key: formKey,
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
                                validator: validateTextfield,
                                obsecure: true,
                                controller: _passwordcontroller,
                                hintText: 'Enter your password',
                              ),
                            ],
                          ),
                        ),
                        h10,
                        const ForgetPassword(),
                        h10,
                        BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            if (state is LoginLoading) {
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
                                  if (formKey.currentState!.validate()) {
                                    if (_emailcontroller.text ==
                                            "admin@gmail.com" &&
                                        _passwordcontroller.text ==
                                            "Admin@123") {
                                      Navigator.pushReplacement(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (_) => const AdminHomePage()));
                                    } else {
                                      loginbloc.add(LoginButtonClickEvent(
                                          email: _emailcontroller.text,
                                          password: _passwordcontroller.text));
                                    }
                                  } else {
                                    warningSnakbar(
                                        context, 'Fill All Fields', red);
                                  }
                                },
                                child: const Text('Log In',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: white,
                                        fontSize: 17)));
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Image.asset(
                      loginbg,
                      width: size.width,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Dont have an Account?  ',
                        style: GoogleFonts.poppins(
                          color: darkgrey,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(CupertinoPageRoute(
                                builder: (c) => const RegisterScreen()));
                          },
                          child: Text(
                            'Register',
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
          ),
        );
      },
    );
  }
}
