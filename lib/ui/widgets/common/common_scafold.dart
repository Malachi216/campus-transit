import 'package:campus_transit/core/constants.dart';
import 'package:campus_transit/core/navigator/navigator.dart';
import 'package:campus_transit/logic/vxmutations.dart';
import 'package:campus_transit/ui/widgets/campus_transit_row.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../logic/vxstore.dart';
import '../containers/bezierContainer.dart';
import '../indicators/common_progress_indicator.dart';
import '../indicators/loading_overlay.dart';


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
  final bool showLeading;

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
    this.showLeading = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TransitStore store = VxState.store;
    return Scaffold(

      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: AppBar(
        leading: showLeading?
            _leadingWidget(context): null,
        backgroundColor: Colors.white, //UIData.scaffoldBackgroundColor,
        centerTitle: true,
        elevation: 0.0,
        // title: AppBarText('Dates'),
        title: CampusTransitRow(),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: VxBuilder<TransitStore>(
          mutations: {UpdateLoadingStatus},
          builder:
              (BuildContext context, TransitStore store, VxStatus status) =>
                  LoadingOverlay(
            isLoading: store.isLoading,
            child: Stack(
              children: [
                Center(
                  child: Image.asset('assets/images/truck.png'),
                ),
                child,
              ],
            ),
            opacity: loadingOverlayOpacity,
            progressIndicator: progressIndicator,
            color: overlayColor,
          ),
        ),
        // child: child,
      ),
      bottomNavigationBar: bottomNavigationBar,
      endDrawer: endDrawer,
      drawer: drawer,
      persistentFooterButtons: persistentFooterButtons,
    );
  }

  Widget _leadingWidget(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        iconSize: 24.0,
        color: UIData.greyColor,
        onPressed: () {
          FocusScope.of(context).unfocus();
          TransitNavigator.pop(context);
        },
      ),
    );
  }


}

class AppBarText extends StatelessWidget {
  final String label;
  final Color color;
  const AppBarText(this.label, {Key key, this.color = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: UIData.onBoardingHeaderTextStyle.copyWith(color: color),
    );
  }
}
