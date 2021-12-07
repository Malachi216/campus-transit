import 'package:campus_transit/core/constants.dart';
import 'package:campus_transit/core/navigator/navigator.dart';
import 'package:campus_transit/core/styles.dart';
import 'package:campus_transit/ui/widgets/campus_transit_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  _navigate() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    TransitNavigator.navigateToLanding(context);
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(color: UIData.primaryColor),
          child: Padding(
            padding: EdgeInsets.only(top: 40.0, bottom: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Image(
                    image: AssetImage(
                      'assets/images/logo.png',
                    ),
                    color: Colors.white,
                    height: 200.0,
                    width: 200.0,
                  ),
                ),
                SizedBox(height: 50.0),
                CampusTransitText(),
                SizedBox(height: _size.height / 6),
                Text('by', style: commonStyle),
                HeightBox(15),
                Text(
                  'Malachi Olaoluwa',
                  style: commonStyle.copyWith(fontSize: 16.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
