import 'package:campus_transit/logic/vxmutations.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:velocity_x/velocity_x.dart';
import 'vxstore.dart';

abstract class AuthEffects implements VxEffects<auth.User> {
  @override
  fork(auth.User user) async {
    if (user != null) {
      success(user);
    } else {
      fail(user);
    }
  }

  void success(auth.User user);
  void fail(auth.User user);
}

abstract class PlacesEffects implements VxEffects<auth.User> {
  @override
  fork(auth.User user) async {
    if (user != null) {
      success(user);
    } else {
      fail(user);
    }
  }

  void success(auth.User user);
  void fail(auth.User user);
}


class SignInWithEmail extends VxMutation<TransitStore> with AuthEffects {
  auth.User user;
  final String emailAddress;
  final String password;
  final BuildContext context;

  SignInWithEmail(this.context, this.emailAddress, this.password);

  Future<auth.User> perform() async {
    UpdateLoadingStatus(true);
    return await _signInWithEmailAndLink();
  }

  Future<auth.User> _signInWithEmailAndLink() async {
    auth.User user;
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        _showErrorToast('Check your credentials and try again');
      } else if (e.code == 'user-disabled') {
        _showErrorToast('This account has been disabled');
      } else if (e.code == 'user-not-found') {
        _showErrorToast('This user does not exist');
      } else if (e.code == 'wrong-password') {
        _showErrorToast('Check your credentials and try again');
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

  _showErrorToast(String errorMessage) {
    Fluttertoast.showToast(msg: errorMessage);
    UpdateLoadingStatus(false);
  }

  success(auth.User user) {
    UpdateLoadingStatus(false);
    store.isLoading = false;
  }

  fail(auth.User user) {
    UpdateLoadingStatus(false);
    store.err = "Couldn't sign in.";
  }

  onException(e, StackTrace s) {
    UpdateLoadingStatus(false);
    store.err = '$e';
  }
}
