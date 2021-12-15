import 'package:campus_transit/core/constants.dart';
import 'package:campus_transit/core/navigator/navigator.dart';
import 'package:campus_transit/logic/vxmutations.dart';
import 'package:campus_transit/logic/vxstore.dart';
import 'package:campus_transit/models/transit_user.dart';
import 'package:campus_transit/services/firebase_controller.dart';
import 'package:campus_transit/ui/widgets/common/common_button.dart';
import 'package:campus_transit/ui/widgets/common/common_scafold.dart';
import 'package:campus_transit/ui/widgets/common/common_textfield.dart';
import 'package:campus_transit/ui/widgets/containers/boxes.dart';
import 'package:campus_transit/ui/widgets/svg_icon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:velocity_x/velocity_x.dart';

class ScanQrCodeScreen extends StatefulWidget {
  const ScanQrCodeScreen({Key key}) : super(key: key);

  @override
  State<ScanQrCodeScreen> createState() => _ScanQrCodeScreenState();
}

class _ScanQrCodeScreenState extends State<ScanQrCodeScreen> {
  String email;
  String password;
  bool obscureText = false;
  TransitStore _store;
  EdgeInsets commonPadding = EdgeInsets.symmetric(horizontal: 20.0);

  @override
  Widget build(BuildContext context) {
    Size _size;
    _size = MediaQuery.of(context).size;
    _store = (VxState.store as TransitStore);

    return CommonScaffold(
      backgroundColor: UIData.primaryColor,
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            HeightDividerBox(50),
            Text('CONTACT US'),
        _qrScanner(),
            HeightDividerBox(50),
            CommonButton(),
            HeightBox(30),
          ],
        ),
      ),
    );
  }

  Widget _qrScanner(){
    return 
  }

  _sendMessage() async {
    UpdateLoadingStatus(true);
    await Future.delayed(const Duration(milliseconds: 2000));
    UpdateLoadingStatus(false);
    await Fluttertoast.showToast(msg: 'Message sent successfully');
    TransitNavigator.pop(context);
  }

}
