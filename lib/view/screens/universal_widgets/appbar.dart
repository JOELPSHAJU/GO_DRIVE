import 'package:flutter/material.dart';
import 'package:godrive/core/colors.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const AppbarWidget({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/appbar.jpg',
            fit: BoxFit.cover,
          ),
        ),
        AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          title: Text(
            title,
            style: const TextStyle(
              color: white,
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: Colors.white,
              height: 1.0,
            ),
          ),
          iconTheme: const IconThemeData(color: white),
        ),
      ],
    );
  }
}
