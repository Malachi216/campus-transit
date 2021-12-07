import 'package:campus_transit/ui/widgets/common_scafold.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatelessWidget {

const SigninScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      child: Center(
        child: Text('SigninScreen'),
     ),
   );
  }
}