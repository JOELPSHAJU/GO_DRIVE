import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'add_advertisement_event.dart';
part 'add_advertisement_state.dart';

class AdvertisementBloc extends Bloc<AdvertisementEvent, AdvertisementState> {
  final CollectionReference advertisementsReference =
      FirebaseFirestore.instance.collection('advertisements');

  AdvertisementBloc() : super(AdvertisementInitial()) {
    on<FetchAdvertisementsEvent>((event, emit) async {
      emit(AdvertisementLoading());

      try {
        final snapshot = await advertisementsReference.get();
        final imagePaths =
            snapshot.docs.map((doc) => doc.get('image') as String).toList();
        final documentIds = snapshot.docs.map((doc) => doc.id).toList();

        emit(AdvertisementFetchSuccess(imagePaths, documentIds));
      } catch (e) {
        emit(AdvertisementError('Failed to fetch advertisements.'));
      }
    });

    on<AddAdvertisementEvent>((event, emit) async {
      emit(AdvertisementLoading());

      try {
        final String imageUrl = await _uploadImage(event.image);
        await advertisementsReference.add({"image": imageUrl});

        emit(AdvertisementAddedSuccess());
        add(FetchAdvertisementsEvent());
      } catch (e) {
        emit(AdvertisementError('Failed to add advertisement.'));
      }
    });

    on<DeleteAdvertisementEvent>((event, emit) async {
      emit(AdvertisementLoading());

      try {
        await advertisementsReference.doc(event.documentId).delete();

        emit(AdvertisementDeletedSuccess());
        add(FetchAdvertisementsEvent());
      } catch (e) {
        emit(AdvertisementError('Failed to delete advertisement.'));
      }
    });
  }

  Future<String> _uploadImage(XFile image) async {
    final Reference ref =
        FirebaseStorage.instance.ref().child('Advertisements/${image.name}');
    final UploadTask uploadTask = ref.putFile(File(image.path));

    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }
}
