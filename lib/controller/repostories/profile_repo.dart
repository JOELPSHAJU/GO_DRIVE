import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:godrive/model/user_profile_model.dart';

class ProfileRepo {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;
  static Future<Map<String, dynamic>?> fetchProfileDetails() async {
    try {
      if (FirebaseAuth.instance.currentUser == null) {
        throw Exception("User not signed in");
      }

      final docRef = FirebaseFirestore.instance
          .collection('ProfileDetails')
          .doc(FirebaseAuth.instance.currentUser?.email);

      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        return docSnapshot.data();
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching profile details: $e');
      }
      return null;
    }
  }

  static Future<String?> uploadProfileDetails(ProfileModel data) async {
    try {
      String? profileImageUrl = await uploadImage(data.profilePicture);
      if (profileImageUrl != null) {
        data.profilePicture = profileImageUrl;
      } else {
        throw Exception("Failed to upload profile image");
      }

      String? coverImageUrl = await uploadImage(data.coverPicture);
      if (coverImageUrl != null) {
        data.coverPicture = coverImageUrl;
      } else {
        throw Exception("Failed to upload cover image");
      }

      final docRef = FirebaseFirestore.instance
          .collection('ProfileDetails')
          .doc(FirebaseAuth.instance.currentUser?.email);

      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        await docRef.update(data.toMap());
      } else {
        await docRef.set(data.toMap());
      }

      return 'success';
    } catch (e) {
      if (kDebugMode) {
        print('Error uploading profile details: $e');
      }
      return e.toString();
    }
  }

  static Future<String?> uploadImage(String imagePath) async {
    try {
      File file = File(imagePath);
      if (!file.existsSync()) {
        throw Exception("File does not exist at path: $imagePath");
      }

      String filename = DateTime.now().microsecondsSinceEpoch.toString();
      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImage = referenceRoot.child('Profile');
      Reference referenceDirImageToUpload = referenceDirImage.child(filename);

      await referenceDirImageToUpload.putFile(file);
      final displayImage = await referenceDirImageToUpload.getDownloadURL();
      return displayImage;
    } catch (e) {
      if (kDebugMode) {
        print('Error uploading image: $e');
      }
      return null;
    }
  }

 static Future<String?> updateProfileDetails(
  ProfileModel data,
  String documentId,
  String profileImage,
  String coverImage,
) async {
  try {
    final currentUserEmail = FirebaseAuth.instance.currentUser?.email;
    if (currentUserEmail == null) {
      return 'User is not logged in';
    }

    final docRef = FirebaseFirestore.instance
        .collection('ProfileDetails')
        .doc(currentUserEmail);

    final docSnapshot = await docRef.get();

    if (!docSnapshot.exists) {
      return 'Document does not exist';
    }

  
    Map<String, dynamic>? existingData = docSnapshot.data();
    if (existingData == null) {
      return 'Existing profile data not found';
    }

 
    if (profileImage.isEmpty) {
      data.profilePicture = existingData['profilePicture'] ?? '';
    } else {
    
      String? profileImageUrlUpdate = await uploadImage(profileImage);
      if (profileImageUrlUpdate != null && profileImageUrlUpdate.isNotEmpty) {
        data.profilePicture = profileImageUrlUpdate;
      } else {
        return 'Profile image upload failed';
      }
    }

  
    if (coverImage.isEmpty) {
      data.coverPicture = existingData['coverPicture'] ?? '';
    } else {
 
      String? coverImageUrlUpdate = await uploadImage(coverImage);
      if (coverImageUrlUpdate != null && coverImageUrlUpdate.isNotEmpty) {
        data.coverPicture = coverImageUrlUpdate;
      } else {
        return 'Cover image upload failed';
      }
    }

    await docRef.update(data.toMap());
    return 'success';
  } catch (e) {
    if (kDebugMode) {
      print('Error updating profile details: $e');
    }
    return 'Error: ${e.toString()}';
  }
}

}
