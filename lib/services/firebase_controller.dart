import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseController {
  static FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // FirebaseController._() {
  // }

  static Future<dynamic> signup(String email, String password) async {
    String signupError;
    User signedUser;
    try {
      //  final AuthCredential credential = AuthCredential(providerId: providerId, signInMethod: signInMethod)
      User user = (await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      if (user != null) {
        signedUser = user;
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      signupError = 'Error from sign up : $e';
      return signupError;
    } catch (e) {
      print(e);
      signupError = 'Error from sign up : $e';
      return signupError;
    }
    return signedUser;
  }

  static Future<dynamic> signin(String email, String password) async {
    String signupError;
    User signedUser;
    try {
      signedUser = (await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
    } on FirebaseAuthException catch (e) {
      print(e);
      signupError = 'Error from sign up : $e';
      return signupError;
    } catch (e) {
      print(e);
      signupError = 'Error from sign up : $e';
      return signupError;
    }
    return signedUser;
  }

  static Future<void> signout() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed to sign out');
      print(e);
    }
  }
}
