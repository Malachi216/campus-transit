import 'package:flutter/material.dart';

class ExpandedBox extends StatelessWidget {
  final int flex;
  const ExpandedBox({Key key, this.flex = 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: SizedBox(),
    );
  }
}

class HeightDividerBox extends StatelessWidget {
  final double divider;
  const HeightDividerBox(this.divider,{Key key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight/divider,
    );
  }
}

class WidthDividerBox extends StatelessWidget {
  final double divider;
  const WidthDividerBox(this.divider,{Key key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth/divider,
    );
  }
}

