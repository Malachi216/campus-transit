import 'package:campus_transit/core/navigator/routes.dart';
import 'package:campus_transit/ui/screens/contact.dart';
import 'package:campus_transit/ui/screens/home.dart';
import 'package:campus_transit/ui/screens/search_for_buses.dart';
import 'package:campus_transit/ui/screens/sign_in.dart';
import 'package:campus_transit/ui/screens/sign_up.dart';
import 'package:campus_transit/ui/screens/splash.dart';
import 'package:campus_transit/ui/screens/tickets.dart';
import 'package:flutter/cupertino.dart';
import 'package:velocity_x/velocity_x.dart';

Map<Pattern, VxPageBuilder> get routes => {
    Routes.splashRoute: (_, __) => CupertinoPage(child: SplashScreen()),
    Routes.homeRoute: (_, __) => CupertinoPage(child: HomeScreen()),
    Routes.signupRoute: (_, __) => CupertinoPage(child: SignupScreen()),
    Routes.signinRoute: (_, __) => CupertinoPage(child: SigninScreen()),
    Routes.contactRoute: (_, __) => CupertinoPage(child: ContactUsScreen()),
    Routes.bookATicket: (_, __) => CupertinoPage(child: SearchForBuses()),
    Routes.tickets: (_, __) => CupertinoPage(child: TicketsScreen()),

    Routes.selectDesiredBus: (_, __) => CupertinoPage(child: SelectDesiredBusScreen()),
    // Routes.welcomeRoute: (_, __) => CupertinoPage(child: WelcomeScreen()),
  };
