import 'package:campus_transit/core/constants.dart';
import 'package:flutter/material.dart';

class CampusTransitText extends StatelessWidget {
  const CampusTransitText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: <InlineSpan>[
          TextSpan(text: 'CAMPUS ', style: UIData.campusStyle),
          TextSpan(text: 'TRANSIT', style: UIData.transitStyle),
        ],
      ),
    );
  }
}
