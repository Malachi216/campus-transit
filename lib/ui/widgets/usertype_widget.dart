import 'package:flutter/material.dart';

class UserTypeWidget extends StatelessWidget {
  final bool displayWidget;
  final Widget child;
  final Widget alternativeWidget;
  final Duration duration;

  const UserTypeWidget({
    Key key,
    @required this.displayWidget,
    @required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.alternativeWidget = const SizedBox(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!displayWidget) return alternativeWidget;
    return child;
  }
}

