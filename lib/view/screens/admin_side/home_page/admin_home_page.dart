import 'package:flutter/material.dart';
import 'package:godrive/view/screens/admin_side/home_page/widgets/drawer.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const AdminDrawer(),
    );
  }
}
