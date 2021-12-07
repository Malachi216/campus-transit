import 'package:campus_transit/ui/screens/page_not_found.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'core/constants.dart';
import 'core/navigator/routes_builder.dart';


class CampusTransitApp extends StatefulWidget {
  @override
  _CampusTransitAppState createState() => _CampusTransitAppState();
}

class _CampusTransitAppState extends State<CampusTransitApp> {
  var _delegate = VxNavigator(
    notFoundPage: (uri, params) => MaterialPage(
      key: ValueKey('not-found-page'),
      child: Builder(
        builder: (context) => PageNotFoundWidget(uri: uri),
      ),
    ),
    routes: routes,
  );
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: UIData.appName,
      theme: ThemeData(
        primarySwatch: UIData.materialPrimaryColor,
        fontFamily: UIData.poppins,
      ),
      routerDelegate: _delegate,
      debugShowCheckedModeBanner: false,
      routeInformationParser: VxInformationParser(),
    
    );
  }
}
