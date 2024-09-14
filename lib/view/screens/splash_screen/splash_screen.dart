// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:godrive/core/colors.dart';
import 'package:godrive/core/constants.dart';

import 'package:godrive/main.dart';
import 'package:godrive/view/bloc/get_profile_bloc/get_profile_bloc.dart';
import 'package:godrive/view/screens/user_side/login_screen.dart/login_screen.dart';
import 'package:godrive/view/screens/user_side/main_screen/main_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkUserLoggedIn();
    context.read<GetProfileBloc>().add(GetProfileDetailsInitialEvent());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: black,
      body: SingleChildScrollView(
        child: Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(splashbg),
                    fit: BoxFit.cover,
                    opacity: 0.5)),
            child: SizedBox(
              height: size.height,
              width: size.width,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * .45,
                    width: size.width,
                  ),
                  SizedBox(
                    height: size.height * .18,
                    width: size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('G O   D R I V E',
                            style: TextStyle(
                                fontSize: size.width * .09,
                                fontWeight: FontWeight.w500,
                                color: Colors.white)),
                        const SizedBox(height: 10),
                        Text('Your Ultimate Travel Companion',
                            style: GoogleFonts.poppins(
                              fontSize: size.width * .04,
                              color: const Color.fromARGB(150, 255, 255, 255),
                            )),
                      ],
                    ),
                  ),
                  Expanded(
                      child: SizedBox(
                    height: size.height,
                    width: size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        LottieBuilder.asset(
                          loading,
                          width: size.width * .5,
                        )
                      ],
                    ),
                  ))
                ],
              ),
            )),
      ),
    );
  }

  Future<void> gotoHome() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (ctx) => MainScreen()));
  }

  Future<void> gotoLogin() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (ctx) => const LoginScreen()));
  }

  Future<void> checkUserLoggedIn() async {
    // ignore: no_leading_underscores_for_local_identifiers
    final _sharedprefs = await SharedPreferences.getInstance();
    final userloggedIn = _sharedprefs.getBool(SAVE_KEY_NAME);
    if (userloggedIn == null || userloggedIn == false) {
      gotoLogin();
    } else {
      gotoHome();
    }
  }
}
