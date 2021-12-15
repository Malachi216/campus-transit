import 'package:campus_transit/core/constants.dart';
import 'package:campus_transit/core/navigator/navigator.dart';
import 'package:campus_transit/logic/validators.dart';
import 'package:campus_transit/logic/vxstore.dart';
import 'package:campus_transit/models/transit_user.dart';
import 'package:campus_transit/services/firebase_controller.dart';
import 'package:campus_transit/ui/widgets/common/common_button.dart';
import 'package:campus_transit/ui/widgets/common/common_scafold.dart';
import 'package:campus_transit/ui/widgets/common/common_textfield.dart';
import 'package:campus_transit/ui/widgets/containers/boxes.dart';
import 'package:campus_transit/ui/widgets/display_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:velocity_x/velocity_x.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String email;
  String password;
  String confirmPassword;
  EdgeInsets commonPadding = EdgeInsets.symmetric(horizontal: 20.0);
  int index = 0;
  int numberOfSeats = 0;
  String phoneNumber;
  String busNumber;
  bool obscureText = false;
  bool confirmObscureText = false;
  TransitStore _store;

  String transitName;
  TransitUser transitUser = TransitUser();

  @override
  Widget build(BuildContext context) {
    Size _size;
    _size = MediaQuery.of(context).size;
    _store = (VxState.store as TransitStore);

    return CommonScaffold(
      backgroundColor: UIData.primaryColor,
      child: Form(
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,

          children: [
            HeightDividerBox(5),
            driverPassengerTab(),
            HeightDividerBox(30),
            CommonTextField(
              hintText: 'Enter your name',
              padding: commonPadding,
              onChanged: (String value) {
                transitUser.name = value;
              },
            ),
            HeightDividerBox(50),

            CommonTextField(
              hintText: 'Enter your email',
              padding: commonPadding,
              keyboardType: TextInputType.emailAddress,
              onChanged: (String value) {
                email = value;
                transitUser.emailAddress = value;
              },
              validator: Validators.signUpEmailValidator,
            ),
            HeightDividerBox(50),

            CommonTextField(
              hintText: 'Phone Number',
              onChanged: (value) {
                transitUser.phoneNumber = value;
              },
              padding: commonPadding,
              keyboardType: TextInputType.phone,
              autofocus: false,
              maxLines: 1,
              validator: Validators.signUpPhoneNumberValidator,
            ),
            HeightDividerBox(50),

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
              onChanged: (value) {
                password = value;
              },
            ),
            HeightDividerBox(50),
            CommonTextField(
              padding: commonPadding,
              hintText: 'Confirm your password',
              obscureText: confirmObscureText,
              maxLines: 1,
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    confirmObscureText = !confirmObscureText;
                  });
                },
                child: Icon(Icons.remove_red_eye),
              ),
              onChanged: (value) {
                confirmPassword = value;
              },
            ),
            HeightDividerBox(50),
            DisplayWidget(
              displayWidget: index == 0,
              child: _passengerDetails(),
              alternativeWidget: _driverDetails(),
            ),
            HeightDividerBox(30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _size.width / 6),
              child: CommonButton(
                label: 'NEXT',
                onPressed: _signup,
              ),
            ),
            HeightBox(10),
            Center(
              child: GestureDetector(
                onTap: _navigateToSignIn,
                child: Text(
                  'Already have an account? LOGIN here',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            HeightDividerBox(20),
          ],
        ),
      ),
    );
  }

  Widget _driverDetails() {
    return Column(
      children: [
        CommonTextField(
          hintText: 'TRANSIT Name',
          padding: commonPadding,
          onChanged: (String value) {
            transitName = value;
          },
        ),
        HeightDividerBox(50),
        CommonTextField(
          padding: commonPadding,
          hintText: 'BUS NUMBER',
          onChanged: (String value) {
            busNumber = value;
          },
        ),
        //ac
        //
        HeightDividerBox(50),
        CommonTextField(
          padding: commonPadding,
          hintText: 'Number of seats',
          onChanged: (String value) {
            numberOfSeats = int.tryParse(value);
          },
        ),
      ],
    );
  }

  Widget _passengerDetails() {
    return Column(
      children: [],
    );
  }

  Future<void> _signup() async {
    print('signup');
    if (password != confirmPassword) {
      await Fluttertoast.showToast(msg: 'Passwords do not match');
      return;
    }
    dynamic result = await FirebaseController.signup(transitUser, password);
    if (result is TransitUser) {
      await Fluttertoast.showToast(msg: 'Signed up successfully');
      _store.user = result;
      TransitNavigator.navigateToHome(context);
    } else {
      await Fluttertoast.showToast(msg: result);
    }
  }

  void _navigateToSignIn() {
    TransitNavigator.navigateToSignIn(context);
  }

  UserType get userType => index == 0 ? UserType.PASSENGER : UserType.DRIVER;

  Widget driverPassengerTab() {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        width: size.width / 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: UIData.greyColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            UserTab(
              isSelected: index == 0,
              label: 'Passenger',
              onPressed: () {
                setState(() {
                  index = 0;
                });
              },
            ),
            UserTab(
              isSelected: index == 1,
              label: 'Driver',
              onPressed: () {
                setState(() {
                  index = 1;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class UserTab extends StatelessWidget {
  final bool isSelected;
  final String label;
  final VoidCallback onPressed;
  const UserTab({
    Key key,
    this.isSelected = false,
    this.label,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size.width / 4,
        height: 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected ? Colors.white : Colors.transparent,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.black,
              fontSize: 12.0,
            ),
          ),
        ),
      ),
    );
  }
}
