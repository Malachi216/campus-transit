import 'package:campus_transit/core/constants.dart';
import 'package:campus_transit/core/navigator/navigator.dart';
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

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
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
        child: ListView(
          children: [
            HeightDividerBox(3),
            //    Image.asset(
            //   'assets/images/logo.png',
            //   // height: 60,
            //   // width: 60,
            // ),
            // HeightDividerBox(50),
            CommonTextField(
              hintText: 'Enter your email',
              padding: commonPadding,
              onChanged: (String value) {
                email = value;
              },
            ),
            HeightDividerBox(30),
            CommonTextField(
              padding: commonPadding,
              hintText: 'Enter your password',
              obscureText: obscureText,
              maxLines: 1,
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                child: Icon(Icons.remove_red_eye),
              ),
            ),
            HeightDividerBox(30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _size.width / 6),
              child: CommonButton(
                onPressed: _signIn,
                label: 'Login',
              ),
            ),
            HeightDividerBox(40),
            Center(
              child: GestureDetector(
                onTap: _navigateToSignUp,
                child: Text(
                  'Dont have an account? sign up here',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _signIn() async {
    print('signin');

    dynamic result = await FirebaseController.signin(email, password);
    if (result is User) {
      await Fluttertoast.showToast(msg: 'Signed up successfully');
      // _store.user = TransitUser.fromFirebaseUser(result, userType);
      TransitNavigator.navigateToHome(context);
    } else {
      await Fluttertoast.showToast(msg: result);
    }
  }

  _navigateToSignUp() {
    TransitNavigator.navigateToSignUp(context);
  }
}
