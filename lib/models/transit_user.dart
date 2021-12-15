import 'package:campus_transit/core/utiltities/utitlities.dart';
import 'package:campus_transit/models/tickets_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UsersResults {
  List<TransitUser> users;

  UsersResults(this.users);

  UsersResults.fromMap(dynamic map) {
    if (map != null) {
      users = <TransitUser>[];
      map.forEach((key, value) {
        if (value is Map) {
          users.add(TransitUser.fromMap(value));
        }
      });
    }
  }

  UsersResults.fromSnapshot(snapshot) : this.fromMap(snapshot.value);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.users != null) {
      data = Map.fromIterable(this.users, key: (v) => v[0], value: (v) => v[1]);
    }
    return data;
  }
}

class TransitUser {
  String description;
  String userId;
  String name;
  UserType userType;
  dynamic phoneNumber;
  String emailAddress;
  List<Ticket> tickets;

  TransitUser({
    this.userType = UserType.PASSENGER,
    this.description,
    this.userId,
    this.name,
    this.phoneNumber,
    this.tickets,
    this.emailAddress,
  });

  TransitUser.fromMap(dynamic map)
      : userId = map['userId'],
        name = map['name'] ?? '',
        phoneNumber = map['phoneNumber'],
        emailAddress = map['emailAddress'],

        // //   //user configurations
        userType = map['userType'] != null
            ?
            UserType.values[map['userType']]
            : UserType.PASSENGER;
  // //   //location
  TransitUser.fromFirebaseUser(User user, UserType type) {
    TransitUser transitUser = TransitUser(
      userId: user.uid,
      userType: type,
      name: user.displayName,
      phoneNumber: user.phoneNumber,
      emailAddress: user.email,
    );
  }
}

enum UserType { PASSENGER, DRIVER, ADMIN }
