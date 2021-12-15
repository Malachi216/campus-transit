import 'package:campus_transit/core/constants.dart';
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
import 'package:fluttertoast/fluttertoast.dart';
import 'package:velocity_x/velocity_x.dart';

TextStyle commonTextStyle = TextStyle(
  color: Color(0xffB7E0EF),
  fontSize: 18.0,
);
final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransitStore _store;
    _store = (VxState.store as TransitStore);
    return Scaffold(
      key: _key,
      appBar: AppBar(
        leading: _commonLeading(context),
        backgroundColor: Colors.white, //UIData.scaffoldBackgroundColor,
        centerTitle: true,
        elevation: 0.0,
        // title: AppBarText('Dates'),
        title: CampusTransitRow(),
      ),
      drawer: Drawer(
        backgroundColor: Color(0xff193B64),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xff193B64),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AvatarIcon(
                    height: 50,
                    width: 50,
                  ),
                  HeightBox(10),
                  Text(
                    _store.user.name ?? '',
                    style: commonTextStyle,
                  ),
                  HeightBox(10),
                  Text(
                    _store.user.emailAddress ?? '',
                    style: commonTextStyle,
                  ),
                ],
              ),
            ),
            Divider(
              color: UIData.primaryColor,
              height: 2.0,
            ),
            ListTile(
              title: Text(
                'HOME',
                style: commonTextStyle,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(
                'TICKETS',
                style: commonTextStyle,
              ),
              onTap: () {
                TransitNavigator.navigateTo(Routes.tickets, context);
              },
            ),
            ListTile(
              title: Text(
                'BOOK A TICKET',
                style: commonTextStyle,
              ),
              onTap: () {
                TransitNavigator.navigateTo(Routes.bookATicket, context);
              },
            ),
            ListTile(
              title: Text(
                'CONTACT US',
                style: commonTextStyle,
              ),
              onTap: () {
                TransitNavigator.navigateTo(Routes.contactRoute, context);
              },
            ),
            ListTile(
              title: Text(
                'LOGOUT',
                style: commonTextStyle,
              ),
              onTap: () async {
                UpdateLoadingStatus(true);
                await FirebaseController.signout();
                await Future.delayed(const Duration(milliseconds: 2500));
                UpdateLoadingStatus(false);
                await Fluttertoast.showToast(
                  msg: 'You have signed out successfully',
                );
                TransitNavigator.restart(context);
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          HeightDividerBox(5),
          Center(
            child: Text(
              'WELCOME TO CAMPUS TRANSIT',
              style: TextStyle(
                color: UIData.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          HeightBox(10),
          Text(
            "You can now Board Buses to your desired Destination at your comfort",
            textAlign: TextAlign.center,
          ),
          HeightBox(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                child: Text(
                  'Book a Ticket',
                  style: TextStyle(
                    color: UIData.primaryColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
                onTap: () =>
                    TransitNavigator.navigateTo(Routes.bookATicket, context),
              ),
              Text('   NOW!!!'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _commonLeading(context) {
    return IconButton(
      icon: Icon(
        Icons.menu,
        color: UIData.primaryColor,
      ),
      onPressed: () => _key.currentState.openDrawer(),
    );
  }
}
