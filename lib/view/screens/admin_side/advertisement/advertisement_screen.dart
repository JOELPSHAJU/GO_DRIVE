// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:godrive/core/colors.dart';
import 'package:godrive/view/bloc/add_advertisement/add_advertisement_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AddAdvertisement extends StatefulWidget {
  const AddAdvertisement({super.key});

  @override
  State<AddAdvertisement> createState() => _AddAdvertisementState();
}

class _AddAdvertisementState extends State<AddAdvertisement> {
  late CollectionReference advertisementsReference;

  @override
  void initState() {
    super.initState();
    context.read<AdvertisementBloc>().add(FetchAdvertisementsEvent());
  }

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      context
          .read<AdvertisementBloc>()
          .add(AddAdvertisementEvent(image: pickedFile));
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _pickImage(context),
        shape: const CircleBorder(),
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.add_a_photo,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: white),
        backgroundColor: black,
        surfaceTintColor: black,
        centerTitle: true,
        title: const Text(
          'ADD ADVERTISEMENT',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: white, fontSize: 16),
        ),
      ),
      extendBodyBehindAppBar: false,
      body: BlocConsumer<AdvertisementBloc, AdvertisementState>(
        listener: (context, state) {
          if (state is AdvertisementAddedSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  backgroundColor: green50,
                  content: Text('Advertisement added successfully!')),
            );
          } else if (state is AdvertisementDeletedSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  backgroundColor: green50,
                  content: Text('Advertisement deleted successfully!')),
            );
          } else if (state is AdvertisementError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  backgroundColor: red,
                  content: Text('Error: ${state.message}')),
            );
          }
        },
        builder: (context, state) {
          if (state is AdvertisementLoading) {
            return Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.black,
                size: 40,
              ),
            );
          } else if (state is AdvertisementFetchSuccess) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: state.imagePaths.length,
                itemBuilder: (context, index) {
                  final imagePath = state.imagePaths[index];
                  final docId = state.documentIds[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      height: 250,
                      child: Column(children: [
                        CachedNetworkImage(
                            imageUrl: imagePath,
                            fit: BoxFit.cover,
                            width: size.width,
                            placeholder: (context, url) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                            height: 200),
                        TextButton(
                            onPressed: () {
                              context.read<AdvertisementBloc>().add(
                                  DeleteAdvertisementEvent(documentId: docId));
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: red,
                                ),
                                Text(
                                  'Delete Image',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: black),
                                ),
                              ],
                            ))
                      ]),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(
                child: Column(
              children: [
                Text('No advertisements found.'),
              ],
            ));
          }
        },
      ),
    );
  }
}
