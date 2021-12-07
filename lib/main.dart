import 'package:campus_transit/campus_transit_app.dart';
import 'package:campus_transit/core/utiltities/url_strategy/url_strategy.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();


  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(CampusTransitApp());
}
