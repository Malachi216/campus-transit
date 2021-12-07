import 'package:flutter/material.dart';

class DisplayWidget extends StatelessWidget {
  final bool displayWidget;
  final Widget child;
  final Widget alternativeWidget;
  final Duration duration;

  const DisplayWidget({
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

class WrapWidget extends StatelessWidget {
  final bool wrapWidget;
  final Function wrapper;
  final Widget child;

  const WrapWidget({
    Key key,
    @required this.wrapWidget,
    @required this.wrapper,
    this.child = const SizedBox(),
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return wrapWidget
        ? wrapper(
            child: Container(
              child: child,
            ),
          )
        : Container(child: child);
  }
}
