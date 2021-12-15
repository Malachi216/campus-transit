import 'dart:ffi';

import 'package:campus_transit/core/constants.dart';
import 'package:flutter/material.dart';

class CampusTransitText extends StatelessWidget {
  final bool fromSplash;
  const CampusTransitText({
    Key key,
    this.fromSplash = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: <InlineSpan>[
          TextSpan(
            text: 'CAMPUS ',
            style: UIData.campusStyle.copyWith(
              color: fromSplash ? Colors.white : Color(0XFF2B92B7),
            ),
          ),
          TextSpan(
            text: 'TRANSIT',
            style: UIData.transitStyle.copyWith(
              color: fromSplash ? Colors.white : Color(0XFF2B92B7),
            ),
          ),
        ],
      ),
    );
  }
}
