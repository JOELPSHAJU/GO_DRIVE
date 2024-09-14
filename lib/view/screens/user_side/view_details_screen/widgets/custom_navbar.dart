import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:godrive/core/colors.dart';
import 'package:godrive/view/screens/user_side/booking_screen/booking_screen.dart';
import 'package:godrive/view/screens/user_side/comparison_screen/comparison_screen.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final Map<String, dynamic> data;
  const CustomBottomNavigationBar({
    super.key,
    required this.data,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .08,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(CupertinoPageRoute(
                  builder: (s) => ComparisonScreen(data: data)));
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              height: MediaQuery.of(context).size.height * .1,
              width: MediaQuery.of(context).size.width * .5,
              child: const Center(
                child: Text(
                  'Compare',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (c) => BookingScreen(data: data)));
            },
            child: Container(
              height: MediaQuery.of(context).size.height * .08,
              width: MediaQuery.of(context).size.width * .5,
              color: black,
              child: const Center(
                child: Text(
                  'Book Now',
                  style: TextStyle(color: white, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
