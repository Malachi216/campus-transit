import 'package:campus_transit/logic/vxstore.dart';
import 'package:campus_transit/models/transit_user.dart';
import 'package:velocity_x/velocity_x.dart';

class Utilities {
  static TransitStore _store = VxState.store as TransitStore;
  // static TransitStore _picker = ImagePicker();

    static UserType intToUserType(int type) {
    UserType userType;
    if (type == 0) {
      userType = UserType.PASSENGER;
    } else if (type == 'admin') {
      userType = UserType.ADMIN;
    } else if (type == 'driver') {
      userType = UserType.DRIVER;
    }
    return userType;
  }

  static UserType stringToUserType(String type) {
    UserType userType;
    if (type == 'passenger') {
      userType = UserType.PASSENGER;
    } else if (type == 'admin') {
      userType = UserType.ADMIN;
    } else if (type == 'driver') {
      userType = UserType.DRIVER;
    }
    return userType;
  }

  static String userTypeToString(UserType userType) {
    String type;
    if (userType == UserType.PASSENGER) {
      type = 'passenger';
    } else if (userType == UserType.ADMIN) {
      type = 'admin';
    } else if (userType == UserType.DRIVER) {
      type = 'driver';
    } 
    return type;
  }
}
