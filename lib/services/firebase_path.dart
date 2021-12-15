import 'package:cloud_firestore/cloud_firestore.dart';

class FirebasePath {
  FirebasePath._();

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final CollectionReference _userCollection =
      _firestore.collection('users');


  static CollectionReference get userCollection => _userCollection;

  // static CollectionReference particularUserCars(String userWalletAddress) =>
  //     _userCollection.doc(userWalletAddress).collection('vehicles');
}
