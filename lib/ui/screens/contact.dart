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

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  String email;
  String password;
  bool obscureText = false;
  String message;
  EdgeInsets commonPadding = EdgeInsets.symmetric(horizontal: 20.0);

  @override
  Widget build(BuildContext context) {
    Size _size;
    _size = MediaQuery.of(context).size;

    return CommonScaffold(
      child: Form(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 32),
          children: [
            HeightDividerBox(50),
            Center(
              child: Text(
                'CONTACT US',
                style: UIData.campusStyle,
              ),
            ),
            HeightDividerBox(50),
            Text('Message Admin:'),
            HeightDividerBox(10),
            CommonTextField(
              hintText: 'Enter your message',
              padding: commonPadding,
              onChanged: (String value) {
                message = value;
              },
            ),
            HeightDividerBox(30),
            Align(
              alignment: Alignment(0.8, 0.8),
              child: Container(
                height: 45,
                width: 80,
                child: CommonButton(
                  onPressed: _sendMessage,
                  label: 'Send',
                ),
              ),
            ),
            HeightDividerBox(40),
            Padding(
              padding: const EdgeInsets.only(left: 32),
              child: SelectableText('Email: campustransit@gmail.com'),
            ),
            HeightBox(30),
            Padding(
              padding: const EdgeInsets.only(left: 32),
              child: SelectableText('Phone: +234 813 356 7845'),
            ),
            HeightDividerBox(20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _size.width / 6),
              child: CommonButton(
                onPressed: () => TransitNavigator.pop(context),
                label: 'Back',
              ),
            ),
            // HeightDividerBox(10),
          ],
        ),
      ),
    );
  }

  _sendMessage() async {
    if (message != null && message != '') {
      UpdateLoadingStatus(true);
      await Future.delayed(const Duration(milliseconds: 2000));
      UpdateLoadingStatus(false);
      await Fluttertoast.showToast(
        msg:
            'Message sent to the admin successfully...You should get a response soon',
        toastLength: Toast.LENGTH_LONG,
      );
      TransitNavigator.pop(context);
    } else {
      await Fluttertoast.showToast(
          msg: 'Type in a message before hitting send');
    }
  }
}
