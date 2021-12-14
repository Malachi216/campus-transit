import 'package:campus_transit/core/navigator/routes.dart';
import 'package:campus_transit/ui/screens/home.dart';
import 'package:campus_transit/ui/screens/sign_in.dart';
import 'package:campus_transit/ui/screens/sign_up.dart';
import 'package:campus_transit/ui/screens/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:velocity_x/velocity_x.dart';

Map<Pattern, VxPageBuilder> get routes => {
    Routes.splashRoute: (_, __) => CupertinoPage(child: SplashScreen()),
    Routes.homeRoute: (_, __) => CupertinoPage(child: HomeScreen()),
    Routes.signupRoute: (_, __) => CupertinoPage(child: SignupScreen()),
    Routes.signinRoute: (_, __) => CupertinoPage(child: SigninScreen()),
    // Routes.welcomeRoute: (_, __) => CupertinoPage(child: WelcomeScreen()),
  };
