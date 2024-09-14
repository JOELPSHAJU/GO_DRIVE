import 'package:firebase_auth/firebase_auth.dart';
import 'package:godrive/controller/repostories/login_repo.dart';
import 'package:godrive/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginUserRepo {
  //Login (Firebase)
  static Future<String?> loginfunction(
      {required String email, required String password}) async {
    try {
      await Auth().signInWithEmailandPassword(email: email, password: password);
      final sharedpref = await SharedPreferences.getInstance();
      sharedpref.setBool(SAVE_KEY_NAME, true);
      return 'success';
    } on FirebaseAuthException catch (e) {
      return e.toString();
    }
  }

  //Register (Firebase)

 static Future<String?> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await Auth().createUserWithEmailandPassword(
        email: email,
        password: password,
      );
      return 'success';
    } on FirebaseAuthException catch (e) {
      return e.toString();
    }
  }
}
