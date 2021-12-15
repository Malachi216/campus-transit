import 'package:campus_transit/models/tickets_model.dart';
import 'package:campus_transit/models/transit_user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

class TransitStore extends VxStore {
  final Box<dynamic> box;
  final FirebaseApp firebaseApp;
  String err = '';
  TransitUser user = TransitUser(
    userType: UserType.PASSENGER,
    name: 'Tester',
  );
  List<String> Bustops = [
    'Mayfair, Campus Gate, Lagere, Sub, New Market, Anglomoz'
  ];

  List<Ticket> searchTransitResults = [];

  String selectedFromBustop = 'Mayfair';
  String selectedToBustop = 'Anglomoz';
  DateTime selectedTransitTime = DateTime.now();

  bool isLoading = false;

  TransitStore(this.box, this.firebaseApp) {
    initializePrefs();
  }

  initializePrefs() {
//initialize prefs
  }
}

class LogInterceptor extends VxInterceptor {
  @override
  void afterMutation(VxMutation<VxStore> mutation) {
    // print("Current state - ${mutation.store.toString()}");
  }

  @override
  bool beforeMutation(VxMutation<VxStore> mutation) {
    // print("Previous state - ${mutation.store.toString()}");
    return true;
  }
}
