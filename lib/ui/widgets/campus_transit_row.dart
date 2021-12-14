import 'package:campus_transit/core/constants.dart';
import 'package:campus_transit/ui/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'campus_transit_text.dart';

class CampusTransitRow extends StatelessWidget {
  const CampusTransitRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset(
            'assets/images/logo.png',
            // height: 60,
            // width: 60,
          ),
          WidthBox(10),
          CampusTransitText(),
        ],
      ),
    );
  }
}
