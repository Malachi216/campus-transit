import 'package:campus_transit/core/navigator/routes.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class TransitNavigator {
  TransitNavigator._();

  static void navigateTo(String route, BuildContext context) =>
      VxNavigator.of(context).push(Uri.parse(route));

  static void restart(BuildContext context) {
    VxNavigator.of(context).clearAndPush(Uri.parse(Routes.splashRoute));
  }

  // static void navigateFromNotification(String route, BuildContext context,
  //     ReceivedNotification receivedNotification) {
  //   VxNavigator.of(context)
  //       .push(Uri.parse(route), params: receivedNotification);
  // }

  static void pop(BuildContext context) => VxNavigator.of(context).pop();

  static void navigateToSignUp(BuildContext context) =>
      VxNavigator.of(context).push(Uri.parse(Routes.signupRoute));

    static Future<void> navigateToHome(BuildContext context) async =>
      VxNavigator.of(context).clearAndPush(Uri.parse(Routes.homeRoute));    

  static void navigateToSignIn(BuildContext context,
          {bool verifyEmailDeepLink = false}) =>
      VxNavigator.of(context)
          .push(Uri.parse(Routes.signinRoute), params: verifyEmailDeepLink);

  // static void navigateToLanding(BuildContext context) =>
  //     VxNavigator.of(context).clearAndPush(Uri.parse(Routes.welcomeRoute));
}
