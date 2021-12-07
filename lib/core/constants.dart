import 'dart:io';

import 'package:flutter/material.dart';

class UIData {
  UIData._();

//app name
  static const appName = 'Campus Transit';
  //android
  static String get packageName =>
      Platform.isIOS ? iosBundleId : androidPackageName;

  static String androidPackageName = 'com.limitless.campus_transit';
  static String iosBundleId = 'com.limitless.campusTransit';
  static String poppins = 'poppins';

  //bases
  static const baseImagePath = 'assets/images';
  static const baseIconPath = 'assets/icons';

  static const appLogoPath = '$baseIconPath/logo.svg';
  static const truckImagePath = '$baseIconPath/truck.svg';

  

  static const primaryColor = Color(0xFF4098B8);
  static const secondaryColor = Color(0xFF43CDFF);

  static const MaterialColor materialPrimaryColor = const MaterialColor(
    0xFF4098B8,
    const <int, Color>{
      50: const Color(0xFF4098B8),
      100: const Color(0xFF4098B8),
      200: const Color(0xFF4098B8),
      300: const Color(0xFF4098B8),
      400: const Color(0xFF4098B8),
      500: const Color(0xFF4098B8),
      600: const Color(0xFF4098B8),
      700: const Color(0xFF4098B8),
      800: const Color(0xFF4098B8),
      900: const Color(0xFF4098B8),
    },
  );
}
