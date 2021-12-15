import 'package:campus_transit/core/constants.dart';
import 'package:campus_transit/core/navigator/navigator.dart';
import 'package:campus_transit/logic/vxmutations.dart';
import 'package:campus_transit/logic/vxstore.dart';
import 'package:campus_transit/models/transit_user.dart';
import 'package:campus_transit/services/firebase_controller.dart';
import 'package:campus_transit/ui/screens/home.dart';
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
  bool obscureText = true;
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
            HeightDividerBox(10),
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
              onChanged: (String value) {
                password = value;
              },
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

 Future<void> _signIn() async {
    print('signin');
    UpdateLoadingStatus(true);
    dynamic result =
        await FirebaseController.signin(email.trim(), password.trim());
    if (result is User) {
      TransitUser user = await FirebaseController.obtainUser(result.uid);
      _store.user = user;
      UpdateLoadingStatus(false);
      await Fluttertoast.showToast(msg: 'Signed in successfully');
      TransitNavigator.navigateToHome(context);
      // Navigator.pushNamedAndRemoveUntil(context,
      //     MaterialPageRoute(builder: (BuildContext context) {
      //   return HomeScreen();
      // }));
    } else {
      UpdateLoadingStatus(false);
      await Fluttertoast.showToast(msg: 'failed to sign in $result');
    }
  }

  _navigateToSignUp() {
    TransitNavigator.navigateToSignUp(context);
  }
}
