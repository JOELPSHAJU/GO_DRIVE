import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:godrive/core/colors.dart';
import 'package:godrive/core/constants.dart';
import 'package:godrive/model/user_profile_model.dart';
import 'package:godrive/view/bloc/get_profile_bloc/get_profile_bloc.dart';

import 'package:godrive/view/screens/user_side/edit_profile/edit_profile_screen.dart';
import 'package:godrive/view/screens/user_side/home_screen/widgets/user_drawer.dart';
import 'package:godrive/view/screens/user_side/profile_screen/widgets/detail_tile.dart';

ProfileModel logginuserdetails = ProfileModel(
    fullName: '',
    phoneNumber: '',
    profilePicture: '',
    coverPicture: '',
    address: '',
    pincode: '');

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
User? get currentUser => _firebaseAuth.currentUser;

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    context.read<GetProfileBloc>().add(GetProfileDetailsInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: white,
      body: BlocBuilder<GetProfileBloc, GetProfileState>(
        builder: (context, state) {
          if (state is GetProfileLoading) {
          } else if (state is GetProfileSuccess) {
            LoginUserdetails = ProfileModel(
              address: state.profile['address'],
              fullName: state.profile['fullName'],
              phoneNumber: state.profile['phoneNumber'],
              profilePicture: state.profile['coverPicture'],
              coverPicture: state.profile['profilePicture'],
              pincode: state.profile['pincode'],
            );
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 250,
                  width: size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          state.profile['coverPicture'],
                        ),
                        fit: BoxFit.cover),
                    color: grey,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(500),
                        bottomRight: Radius.circular(300)),
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        bottom: -60,
                        left: size.width / 2 - 90,
                        child: Container(
                          height: 170,
                          width: 170,
                          decoration: BoxDecoration(
                              color: grey80,
                              border: Border.all(width: 2, color: white),
                              borderRadius: BorderRadius.circular(100),
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      state.profile['profilePicture']),
                                  fit: BoxFit.cover)),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: black,
                              borderRadius: BorderRadius.circular(100)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: white,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                h40,
                DetailTile(
                  size: size,
                  label: 'Full Name : ',
                  data: state.profile['fullName'],
                ),
                DetailTile(
                  size: size,
                  label: 'Phone Number : ',
                  data: state.profile['phoneNumber'],
                ),
                DetailTile(
                  size: size,
                  label: 'Email Address : ',
                  data: currentUser!.email.toString(),
                ),
                DetailTile(
                  size: size,
                  label: 'Address : ',
                  data: state.profile['address'],
                ),
                DetailTile(
                  size: size,
                  label: 'Pincode : ',
                  data: state.profile['pincode'],
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    height: 50,
                    color: black,
                    onPressed: () {
                      final data = ProfileModel(
                          address: state.profile['address'],
                          fullName: state.profile['fullName'],
                          phoneNumber: state.profile['phoneNumber'],
                          profilePicture: state.profile['profilePicture'],
                          pincode: state.profile['pincode'],
                          coverPicture: state.profile['coverPicture']);
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (_) => EditProfileScreen(
                                    edit: true,
                                    model: data,
                                    id: currentUser!.email,
                                  )));
                    },
                    child: Center(
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: white,
                            fontSize: 17),
                      ),
                    ),
                  ),
                )
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
