import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:godrive/model/car_model.dart';

class InventoryRepo {
  static Future<String?> deleteCarDetail(String documentId) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      await firestore.collection('CarDetails').doc(documentId).delete();
      return 'sucess';
    } catch (e) {
      return e.toString();
    }
  }

  //Popular inventories
  static Future<String?> uploadPopularDetails(Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance.collection('Popular').add(data);
      return 'success';
    } catch (e) {
      if (kDebugMode) {
        print('Error uploading car details: $e');
      }
      return e.toString();
    }
  }

//delete popular Inventories
  static Future<String?> deletepopularInventories(String documentId) async {
    if (kDebugMode) {
      print('entered function');
    }
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      await firestore.collection('Popular').doc(documentId).delete();
      return 'sucess';
    } catch (e) {
      return e.toString();
    }
  }


  static Future<String?> uploadCarDetails(CarModel carModel) async {
    try {
   
      String? mainImageUrl = await uploadImage(carModel.mainImage);
      if (mainImageUrl != null) {
        carModel.mainImage = mainImageUrl;
      } else {
        throw Exception("Failed to upload main image");
      }


      List<String> additionalImageUrls = [];
      for (String image in carModel.additionalImages) {
        String? imageUrl = await uploadImage(image);
        if (imageUrl != null) {
          additionalImageUrls.add(imageUrl);
        }
      }
      carModel.additionalImages = additionalImageUrls;

   
      await FirebaseFirestore.instance
          .collection('CarDetails')
          .add(carModel.toMap());
      return 'success';
    } catch (e) {
      if (kDebugMode) {
        print('Error uploading car details: $e');
      }
      return e.toString();
    }
  }

  static Future<String?> uploadImage(String imagePath) async {
    File file = File(imagePath);
    String filename = DateTime.now().microsecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImage = referenceRoot.child('CarImages');
    Reference referenceDirImageToUpload = referenceDirImage.child(filename);

    try {
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

  static Future<String?> updateCarDetails(CarModel carModel, String documentId,
      String mainimage, List<String> additionalImages) async {
    try {
      final docRef =
          FirebaseFirestore.instance.collection('CarDetails').doc(documentId);
      String? mainimageurlupdate = '';
      List<String> additionalImageUrls = [];

 
      if (mainimage.isNotEmpty) {
        mainimageurlupdate = await InventoryRepo.uploadImage(mainimage);
        if (mainimageurlupdate != null && mainimageurlupdate.isNotEmpty) {
          carModel.mainImage = mainimageurlupdate;
        } else {
          return 'Main image upload failed';
        }
      }

     
      if (additionalImages.isNotEmpty) {
        for (var image in additionalImages) {
          String? imageUrl = await InventoryRepo.uploadImage(image);
          if (imageUrl != null && imageUrl.isNotEmpty) {
            additionalImageUrls.add(imageUrl);
          } else {
            return 'One or more additional images failed to upload';
          }
        }
        carModel.additionalImages = additionalImageUrls;
      }

    
      await docRef.update(carModel.toMap());
      return 'success';
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
  }
}
