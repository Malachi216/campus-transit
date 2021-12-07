 import 'package:flutter/material.dart';

class CommonProgressIndicator extends StatelessWidget {

  final Color color;
  final double size;

  const CommonProgressIndicator({
    Key key,
    this.color = Colors.pinkAccent,
    this.size = 60.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProgressIndicator(
      width: size,
      height: size,
      color: color,
    );
  }
}

class ProgressIndicator extends StatelessWidget {
  const ProgressIndicator({
    Key key,
    @required this.width,
    @required this.height,
    this.color = Colors.pinkAccent,
  }) : super(key: key);

  final double width;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircularProgressIndicator(
        strokeWidth: 2.0,
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
      width: width - 10.0,
      height: height - 10.0,
      padding: EdgeInsets.all(height / 3),
    );
  }
}