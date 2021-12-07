import 'package:campus_transit/core/constants.dart';
import 'package:campus_transit/ui/widgets/svg_icon.dart';
import 'package:flutter/material.dart';

import 'campus_transit_text.dart';

class CampusTransitRow extends StatelessWidget {
  const CampusTransitRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        SvgIcon(
          iconPath: UIData.appLogoPath,
          iconSize: Size(48.0, 48.0),

        ),
        CampusTransitText(),
      ],
    );
  }
}
