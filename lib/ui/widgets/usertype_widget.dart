import 'package:campus_transit/logic/vxstore.dart';
import 'package:campus_transit/models/transit_user.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class UserTypeWidget extends StatelessWidget {
  final Widget passengerWidget;
  final Widget driverWidget;
  final Widget adminWidget;

  const UserTypeWidget({
    Key key,
    @required this.passengerWidget,
    this.driverWidget = const SizedBox(),
    this.adminWidget = const SizedBox(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransitStore store = (VxState.store as TransitStore);    
    if ( store.user.userType == UserType.ADMIN){
      return adminWidget;
    } else if(store.user.userType == UserType.DRIVER){
      return driverWidget;
    }
    return passengerWidget;
  }
}

