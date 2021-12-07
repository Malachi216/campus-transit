import 'package:campus_transit/core/navigator/routes.dart';
import 'package:campus_transit/ui/screens/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:velocity_x/velocity_x.dart';

Map<Pattern, VxPageBuilder> get routes => {
    Routes.splashRoute: (_, __) => CupertinoPage(child: SplashScreen()),
    Routes.homeRoute: (_, __) => CupertinoPage(child: HomeScreen()),
    Routes.signupRoute: (_, __) => CupertinoPage(child: SignUpScreen()),
    Routes.signinRoute: (_, params) => CupertinoPage(child: SignInScreen(params)),
    Routes.welcomeRoute: (_, __) => CupertinoPage(child: LandingScreen()),
  };
