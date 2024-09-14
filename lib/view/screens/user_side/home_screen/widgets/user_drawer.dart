import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:godrive/core/colors.dart';
import 'package:godrive/core/constants.dart';
import 'package:godrive/model/user_profile_model.dart';
import 'package:godrive/view/bloc/get_profile_bloc/get_profile_bloc.dart';
import 'package:godrive/view/screens/user_side/profile_screen/profile_screen.dart';

// ignore: non_constant_identifier_names
ProfileModel LoginUserdetails = ProfileModel(
    fullName: '',
    phoneNumber: '',
    profilePicture: '',
    coverPicture: '',
    address: '',
    pincode: '');

class UserDrawer extends StatefulWidget {
  UserDrawer({super.key});

  @override
  State<UserDrawer> createState() => _UserDrawerState();
}

class _UserDrawerState extends State<UserDrawer> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;
  @override
  void initState() {
    context.read<GetProfileBloc>().add(GetProfileDetailsInitialEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetProfileBloc, GetProfileState>(
        builder: (context, state) {
      if (state is GetProfileLoading) {
      } else if (state is GetProfileSuccess) {
        LoginUserdetails = ProfileModel(
            address: state.profile['address'],
            fullName: state.profile['fullName'],
            phoneNumber: state.profile['phoneNumber'],
            profilePicture: state.profile['profilePicture'],
            coverPicture: state.profile['coverPicture'],
            pincode: state.profile['pincode']);
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(
                  state.profile['fullName'],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                accountEmail: Text(
                  currentUser!.email.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                currentAccountPicture: Container(
                  height: 110,
                  width: 110,
                  decoration: BoxDecoration(
                      border: Border.all(color: white, width: 2),
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            state.profile['profilePicture'],
                          ),
                          fit: BoxFit.cover)),
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      state.profile['coverPicture'],
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ListTile(
                title: const Text(
                  'Profile',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (C) => ProfileScreen()));
                },
              ),
              const Divider(),
              ListTile(
                title: const Text(
                  'Rental Rules',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                title: const Text(
                  'Notifications',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                title: const Text(
                  'Privacy Policies',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                title: const Text(
                  'Terms and Conditions',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                title: const Text(
                  'Sign Out',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {},
              ),
            ],
          ),
        );
      }
      return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text(
                'GO DRIVE',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              accountEmail: const Text(
                '',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              currentAccountPicture: CircleAvatar(
                radius: 55,
                backgroundColor: Colors.black,
                child: ClipOval(
                  child: Image.asset(
                    logoandroid,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(admindrawerimg),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListTile(
              title: const Text(
                'Profile',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (C) => ProfileScreen()));
              },
            ),
            const Divider(),
            ListTile(
              title: const Text(
                'Rental Rules',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              title: const Text(
                'Notifications',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              title: const Text(
                'Privacy Policies',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              title: const Text(
                'Terms and Conditions',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              title: const Text(
                'Sign Out',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {},
            ),
          ],
        ),
      );
    });
  }
}
