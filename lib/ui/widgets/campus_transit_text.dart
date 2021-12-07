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
          TextSpan(text: 'Campus '),
          TextSpan(text: 'Transit'),
        ],
      ),
    );
  }
}
