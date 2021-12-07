import 'package:campus_transit/logic/vxmutations.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../logic/vxstore.dart';
import 'containers/bezierContainer.dart';
import 'indicators/common_progress_indicator.dart';
import 'indicators/loading_overlay.dart';

class CommonScaffold extends StatelessWidget {
  final Widget child;
  final Widget endDrawer;
  final Widget drawer;
  final Widget bottomNavigationBar;
  final Widget progressIndicator;
  final bool isLoading;
  final Color overlayColor;
  final double loadingOverlayOpacity;
  final Color backgroundColor;
  final List<Widget> persistentFooterButtons;
  final bool resizeToAvoidBottomInset;
  
  const CommonScaffold({
    Key key,
    @required this.child,
    this.endDrawer,
    this.bottomNavigationBar,
    this.drawer,
    this.isLoading,
    this.loadingOverlayOpacity = 0.1,
    this.overlayColor,
    this.backgroundColor = const Color(0xFFFAFAFA),
    this.progressIndicator = const CommonProgressIndicator(),
    this.persistentFooterButtons,
    this.resizeToAvoidBottomInset = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransitStore store = VxState.store;
    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: BezierContainer(
          child: VxBuilder(
            mutations: {UpdateLoadingStatus},
            builder: (BuildContext context, _, VxStatus status) => LoadingOverlay(
              isLoading: isLoading ?? store.isLoading,
              child: child,
              opacity: loadingOverlayOpacity,
              progressIndicator: progressIndicator,
              color: overlayColor,
            ),
          ),
        ),
      ),
      bottomNavigationBar: bottomNavigationBar,
      endDrawer: endDrawer,
      drawer: drawer,
      persistentFooterButtons: persistentFooterButtons,
    );
  }
}
