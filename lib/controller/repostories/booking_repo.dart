import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:godrive/model/accept_reject_model.dart';
import 'package:godrive/model/booking_model.dart';

class BookingRepo {
  static Future<String?> uploadbookingdetails(BookingModel data) async {
    try {
      await FirebaseFirestore.instance
          .collection('BookingDetails')
          .doc()
          .set(data.toMap());
      return 'success';
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String?> acceptRejectRequest(
      BookingAcceptRejectModel data, String docId) async {
    try {
      await FirebaseFirestore.instance
          .collection('AcceptRejectDetails')
          .add(data.toMap());
      await FirebaseFirestore.instance
          .collection('BookingDetails')
          .doc(docId)
          .delete();
      return data.status == 'accepted' ? 'accepted' : 'rejected';
    } catch (e) {
      return e.toString();
    }
  }

  static Future<List<Map<String, dynamic>>?>
      fetchbookingacceptrejectuser() async {
    try {
      final userEmail = FirebaseAuth.instance.currentUser!.email;
      if (userEmail == null) return null;
      final snapshot = await FirebaseFirestore.instance
          .collection('AcceptRejectDetails')
          .where('emailAddress', isEqualTo: userEmail)
          .get();
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<List<Map<String, dynamic>>?> fetchPendingOrders() async {
    try {
      final userEmail = FirebaseAuth.instance.currentUser?.email;

      if (userEmail == null) return null;

      final querySnapshot = await FirebaseFirestore.instance
          .collection('BookingDetails')
          .where('emailAddress', isEqualTo: userEmail)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching pending orders: $e');
      return null;
    }
  }

  static Future<List<Map<String, dynamic>>?> fetchAllPendingOrders() async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('BookingDetails').get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          data['documentId'] = doc.id;
          return data;
        }).toList();
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching pending orders: $e');
      return [];
    }
  }
}
