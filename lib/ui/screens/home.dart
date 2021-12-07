import 'package:campus_transit/ui/widgets/common_scafold.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      child: Center(
        child: Text('HomeScreen'),
     ),
   );
  }
}