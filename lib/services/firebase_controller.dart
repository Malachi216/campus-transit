import 'package:campus_transit/models/transit_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'firebase_path.dart';

class FirebaseController {
  static FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  FirebaseController._();

  static Future<TransitUser> obtainUser(
    String userId,
  ) async {
    DocumentSnapshot documentSnapshot =
        await FirebasePath.userCollection.doc(userId).get();
    if (!documentSnapshot.exists) return null;
    return TransitUser.fromMap(documentSnapshot.data());
  }

  static Future<dynamic> signup(
    TransitUser transitUser,
    String password,
  ) async {
    String signupError;
    try {
      //  final AuthCredential credential = AuthCredential(providerId: providerId, signInMethod: signInMethod)
      User user = (await _firebaseAuth.createUserWithEmailAndPassword(
        email: transitUser.emailAddress,
        password: password,
      ))
          .user;
      if (user != null) {
        transitUser.userId = user.uid;
        Map<String, dynamic> data = {
          'userType': transitUser.userType.index,
          'name': transitUser.name,
          'phoneNumber': transitUser.phoneNumber,
          'emailAddress': transitUser.emailAddress,
        };
        DocumentReference userReferencer =
            FirebasePath.userCollection.doc(transitUser.userId);

        await userReferencer
            .set(data)
            .whenComplete(() => print("user registered"))
            .catchError((e) => print(e));
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
    return transitUser;
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
