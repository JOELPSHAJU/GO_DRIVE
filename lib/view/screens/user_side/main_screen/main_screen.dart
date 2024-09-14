import 'package:flutter/material.dart';
import 'package:godrive/core/colors.dart';
import 'package:godrive/core/constants.dart';
import 'package:godrive/view/screens/user_side/favourites_screen/favourites_screen.dart';
import 'package:godrive/view/screens/user_side/home_screen/home_screen.dart';
import 'package:godrive/view/screens/user_side/home_screen/widgets/user_drawer.dart';
import 'package:godrive/view/screens/user_side/login_screen.dart/login_screen.dart';
import 'package:godrive/view/screens/user_side/order_history_screen/order_history_screen.dart';
import 'package:godrive/view/screens/user_side/search_screen/search_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final ValueNotifier<int> _currentIndexNotifier = ValueNotifier<int>(0);

  final List<Widget> pages = [
    const HomeScreen(),
    const SearchScreen(),
    const FavouritesScreen(),
    const OrderHistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: UserDrawer(),
        extendBody: true,
        appBar: AppBar(
          bottomOpacity: 2,
          surfaceTintColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Image.asset(
            logoletterblack,
            width: 130,
          ),
          actions: [
            IconButton(
              onPressed: () async {
                final sharedprefs = await SharedPreferences.getInstance();
                await sharedprefs.clear();
                // ignore: use_build_context_synchronously
                Navigator.pushAndRemoveUntil(
                    (context),
                    MaterialPageRoute(builder: (ctx2) => const LoginScreen()),
                    (route) => false);
              },
              icon: const Icon(Icons.notifications, color: Colors.black),
            ),
          ],
        ),
        body: ValueListenableBuilder<int>(
          valueListenable: _currentIndexNotifier,
          builder: (context, currentIndex, child) {
            return pages[currentIndex];
          },
        ),
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border.symmetric(
              horizontal: BorderSide(width: 1, color: Colors.grey),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: GNav(
              gap: 8,
              color: Colors.black,
              tabBackgroundColor: Colors.black,
              activeColor: Colors.white,
              padding: const EdgeInsets.all(10),
              onTabChange: (value) {
                _currentIndexNotifier.value = value;
              },
              tabs: const [
                GButton(
                  icon: Icons.home_outlined,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.search,
                  text: 'Search',
                ),
                GButton(
                  icon: Icons.favorite,
                  text: 'Favourites',
                  iconActiveColor: red,
                ),
                GButton(
                  icon: Icons.book,
                  text: 'Bookings',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
