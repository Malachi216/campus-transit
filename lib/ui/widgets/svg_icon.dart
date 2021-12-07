import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  final String iconPath;
  final Color iconColor;
  final Size iconSize;

   const SvgIcon({
    Key key,
    @required this.iconPath,
    this.iconColor,
    this.iconSize = const Size(25.0 ,25.0),

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      iconPath,
      color: iconColor,
      height: iconSize.height,
      width: iconSize.width,
    );
  }
}
