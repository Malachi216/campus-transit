import 'dart:io';

import 'package:campus_transit/campus_transit_app.dart';
import 'package:campus_transit/logic/vxstore.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:path_provider/path_provider.dart' as p;
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  var box = await initHive();
  await DotEnv.load();

  FirebaseApp app = await initializeFirebaseDefault();


  runApp(
    VxState(
      store: TransitStore(box, app),
      interceptors: [LogInterceptor()],
      child: CampusTransitApp(),
    ),
  );
}

Future<FirebaseApp> initializeFirebaseDefault() async {
  FirebaseApp app = await Firebase.initializeApp();
  assert(app != null);
  return app;
}

Future<Box<dynamic>> initHive() async {
  final appDocDirectory = await p.getApplicationDocumentsDirectory();
  Directory directory = await Directory(appDocDirectory.path + '/' + 'prefs')
      .create(recursive: true);

  var path = directory.path;

  Hive.init(path);
  Box box = await Hive.openBox('preferences');
  return box;
}


// void main() => runApp(
//       DevicePreview(
//         enabled: !kReleaseMode,
//         builder: (context) => CampusTransitApp(), // Wrap your app
//       ),
//     );
