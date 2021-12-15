import 'package:campus_transit/core/constants.dart';
import 'package:flutter/material.dart';

import 'svg_icon.dart';

class AvatarIcon extends StatelessWidget {
  final double height;
  final double width;
  final Color iconColor;
  final EdgeInsets padding;
  const AvatarIcon({
    Key key,
    this.height,
    this.width,
    this.padding,
    this.iconColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.all(10.0),
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: UIData.avatarIconBackgroundColor,
        shape: BoxShape.circle,
      ),
      child: SvgIcon(
        iconPath: UIData.avatarIconPath,
        iconColor: iconColor,
        iconSize: Size(width, height),
      ),
    );
  }
}
