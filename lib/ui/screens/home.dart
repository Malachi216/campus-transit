import 'package:campus_transit/core/navigator/navigator.dart';
import 'package:campus_transit/core/navigator/routes.dart';
import 'package:campus_transit/logic/vxmutations.dart';
import 'package:campus_transit/logic/vxstore.dart';
import 'package:campus_transit/services/firebase_controller.dart';
import 'package:campus_transit/ui/widgets/avatar_icon.dart';
import 'package:campus_transit/ui/widgets/campus_transit_row.dart';
import 'package:campus_transit/ui/widgets/common/common_scafold.dart';
import 'package:campus_transit/ui/widgets/containers/boxes.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransitStore _store;
    _store = (VxState.store as TransitStore);
    return CommonScaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AvatarIcon(
                    height: 60,
                    width: 60,
                  ),
                  HeightBox(10),
                  Text(_store.user.emailAddress ?? ''),
                  HeightBox(10),
                  Text(_store.user.name ?? ''),
                  HeightBox(20),
                ],
              ),
            ),
            ListTile(
              title: const Text('HOME'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('TICKETS'),
              onTap: () {
                TransitNavigator.navigateTo(Routes.tickets, context);
              },
            ),
            ListTile(
              title: const Text('BOOK A TICKET'),
              onTap: () {
                TransitNavigator.navigateTo(Routes.bookATicket, context);
              },
            ),
            ListTile(
              title: const Text('CONTACT US'),
              onTap: () {
                TransitNavigator.navigateTo(Routes.contactRoute, context);
              },
            ),
            ListTile(
              title: const Text('LOGOUT'),
              onTap: () async {
                UpdateLoadingStatus(true);
                await FirebaseController.signout();
                await Future.delayed(const Duration(milliseconds: 1500));
                TransitNavigator.restart(context);
              },
            ),
          ],
        ),
      ),
      child: Column(
        children: [
          HeightDividerBox(8),
          Center(
            child: Text('WELCOME TO CAMPUS TRANSIT'),
          ),
          Text(
            "You can now Board Buses to your desired Destination at your comfort",
            textAlign: TextAlign.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                child: Text('Book a Ticket Now'),
                onTap: () =>
                    TransitNavigator.navigateTo(Routes.bookATicket, context),
              ),
              Text('NOW!!!'),
            ],
          ),
        ],
      ),
    );
  }
}
