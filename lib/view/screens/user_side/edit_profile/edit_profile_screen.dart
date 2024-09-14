import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:godrive/core/colors.dart';
import 'package:godrive/core/snakbars.dart';
import 'package:godrive/model/user_profile_model.dart';
import 'package:godrive/view/bloc/get_profile_bloc/get_profile_bloc.dart';
import 'package:godrive/view/bloc/profie_edit_bloc/profile_edit_bloc.dart';
import 'package:godrive/view/screens/universal_widgets/loading_button.dart';
import 'package:godrive/view/screens/universal_widgets/validators.dart';
import 'package:godrive/view/screens/user_side/booking_screen/booking_screen.dart';
import 'package:godrive/view/screens/user_side/booking_screen/widgets/textformfield.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class EditProfileScreen extends StatelessWidget {
  final ProfileModel? model;
  final bool edit;
  final String? id;

  EditProfileScreen({
    this.id,
    super.key,
    this.model,
    required this.edit,
  }) {
    if (edit && model != null) {
      coverpicture = model!.coverPicture;
      nameController.text = model!.fullName;
      addressController.text = model!.address;
      phoneController.text = model!.phoneNumber;
      pincodeController.text = model!.pincode;
      profilePicture = model!.profilePicture;
    }
  }
  String profilePicture = '';
  String coverpicture = '';
  late XFile? file;
  late XFile? filecover;
  final formKeyprofile = GlobalKey<FormState>();
  final ValueNotifier<String> pickCoverImageProfile = ValueNotifier('');
  final ValueNotifier<String> pickImageEditProfile = ValueNotifier('');
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: white),
        centerTitle: true,
        backgroundColor: black,
        surfaceTintColor: black,
        title: edit
            ? const Text(
                'EDIT PROFILE',
                style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.bold, color: white),
              )
            : const Text('ADD PROFILE DETAILS',
                style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.bold, color: white)),
      ),
      body: BlocConsumer<ProfileEditBloc, ProfileEditState>(
        listener: (context, state) {
          if (state is ProfileEditSuccess) {
            context.read<GetProfileBloc>().add(GetProfileDetailsInitialEvent());
            Navigator.pop(context);
            successSnakbar(context, 'Data Updates Sucessfully', green50);
          } else if (state is ProfileEditError) {
            return failedSnakbar(context, 'Error Occured', red);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  h10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Profile Picture',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          h10,
                          ValueListenableBuilder<String>(
                            valueListenable: pickImageEditProfile,
                            builder: (context, value, child) {
                              return GestureDetector(
                                onTap: () async {
                                  try {
                                    file = await ImagePicker().pickImage(
                                      source: ImageSource.gallery,
                                    );
                                    if (file != null) {
                                      pickImageEditProfile.value = file!.path;
                                    }
                                  } catch (e) {
                                    if (kDebugMode) {
                                      print('Error picking image: $e');
                                    }
                                  }
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 150,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Color.fromARGB(
                                                  255, 228, 228, 228),
                                              blurRadius: 10,
                                              spreadRadius: 2,
                                              offset: Offset(0, 2))
                                        ],
                                        color: white,
                                      ),
                                      child: profilePicture.isNotEmpty
                                          ? CachedNetworkImage(
                                              imageUrl: profilePicture,
                                              fit: BoxFit.cover,
                                            )
                                          : pickImageEditProfile.value.isEmpty
                                              ? const Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      CupertinoIcons.photo,
                                                      color: lightgrey,
                                                      size: 30,
                                                    ),
                                                  ],
                                                )
                                              : Image.file(
                                                  File(pickImageEditProfile
                                                      .value),
                                                  fit: BoxFit.cover,
                                                ),
                                    ),
                                    if (pickImageEditProfile.value.isNotEmpty)
                                      Positioned(
                                        bottom: 10,
                                        right: 10,
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            color: white,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              pickImageEditProfile.value = '';
                                            },
                                            child: const Icon(
                                              Icons.delete,
                                              color: red,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            'Cover Picture',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          h10,
                          ValueListenableBuilder<String>(
                            valueListenable: pickCoverImageProfile,
                            builder: (context, value, child) {
                              return GestureDetector(
                                onTap: () async {
                                  try {
                                    file = await ImagePicker().pickImage(
                                      source: ImageSource.gallery,
                                    );
                                    if (file != null) {
                                      pickCoverImageProfile.value = file!.path;
                                    }
                                  } catch (e) {
                                    if (kDebugMode) {
                                      print('Error picking image: $e');
                                    }
                                  }
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 150,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Color.fromARGB(
                                                  255, 228, 228, 228),
                                              blurRadius: 10,
                                              spreadRadius: 2,
                                              offset: Offset(0, 2))
                                        ],
                                        color: white,
                                      ),
                                      child: coverpicture.isNotEmpty
                                          ? CachedNetworkImage(
                                              imageUrl: coverpicture,
                                              fit: BoxFit.cover,
                                            )
                                          : pickCoverImageProfile.value.isEmpty
                                              ? const Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      CupertinoIcons.photo,
                                                      color: lightgrey,
                                                      size: 30,
                                                    ),
                                                  ],
                                                )
                                              : Image.file(
                                                  File(pickCoverImageProfile
                                                      .value),
                                                  fit: BoxFit.cover,
                                                ),
                                    ),
                                    if (pickCoverImageProfile.value.isNotEmpty)
                                      Positioned(
                                        bottom: 10,
                                        right: 10,
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            color: white,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              pickCoverImageProfile.value = '';
                                            },
                                            child: const Icon(
                                              Icons.delete,
                                              color: red,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  h20,
                  Form(
                    key: formKeyprofile,
                    child: Column(
                      children: [
                        TextformfieldProject(
                            phonenumberController: nameController,
                            hint: 'Enter Full Name',
                            validator: validateTextfield,
                            type: TextInputType.text),
                        h10,
                        TextformfieldProject(
                            phonenumberController: phoneController,
                            hint: 'Enter Phone Number',
                            validator: validateTextfield,
                            type: TextInputType.phone),
                        h10,
                        TextformfieldProject(
                            phonenumberController: addressController,
                            validator: validateTextfield,
                            hint: 'Enter Address',
                            type: TextInputType.text),
                        h10,
                        TextformfieldProject(
                            phonenumberController: pincodeController,
                            validator: validateTextfield,
                            hint: 'Enter Pin Code',
                            type: TextInputType.phone),
                      ],
                    ),
                  ),
                  h10,
                  BlocBuilder<ProfileEditBloc, ProfileEditState>(
                      builder: (context, state) {
                    if (state is ProfileEditLoading) {
                      return loadingButton(
                          media: size, onPressed: () {}, color: black);
                    }
                    return MaterialButton(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      minWidth: size.width * .5,
                      color: black,
                      height: 50,
                      onPressed: () {
                        if (formKeyprofile.currentState!.validate()) {
                          final data = ProfileModel(
                            fullName: nameController.text,
                            phoneNumber: phoneController.text,
                            profilePicture: pickImageEditProfile.value,
                            coverPicture: pickCoverImageProfile.value,
                            address: addressController.text,
                            pincode: pincodeController.text,
                          );

                          if (edit == true) {
                            context.read<ProfileEditBloc>().add(
                                  updateProfileDetailsEvent(
                                    docId: id!,
                                    profilePictureValue:
                                        pickImageEditProfile.value,
                                    coverPictureValue:
                                        pickCoverImageProfile.value,
                                    data: data,
                                  ),
                                );
                          } else {
                            context.read<ProfileEditBloc>().add(
                                  addProfileDetailsEvent(data: data),
                                );
                          }
                        } else {
                          failedSnakbar(context, 'Fill all Fields', red);
                        }
                        context
                            .read<GetProfileBloc>()
                            .add(GetProfileDetailsInitialEvent());
                      },
                      child: Center(
                        child: edit
                            ? const Text(
                                'UPDATE DETAILS',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, color: white),
                              )
                            : const Text(
                                'ADD DETAILS',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, color: white),
                              ),
                      ),
                    );
                  })
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
