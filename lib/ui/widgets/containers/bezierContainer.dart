import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants.dart';

class BezierContainer extends StatelessWidget {
  final String title;
  final bool showBackButton;
  final double divider;
  final Widget child;
  const BezierContainer({
    Key key,
    this.title = '',
    this.showBackButton = false,
    this.divider = 1.0,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClipPath(
      clipper: ClipPainter(),
      child: CustomPaint(
        painter: MarkerCurvesPainter(),
        child: Container(
          height: size.height / (4 * divider),
          width: size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xffff4664),
                UIData.primaryColor,
              ],
            ),
          ),
          child: Stack(
            children: [
              SvgPicture.asset(
                UIData.truckImagePath,
                height: 200,
                width: 200,
                color: Colors.white.withOpacity(0.6),
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class ClipPainter extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double curveDistance = 40;

    var path = new Path();

    path.moveTo(0, size.height * 0.4);
    path.lineTo(0, size.height - curveDistance - 20);
    path.quadraticBezierTo(1, size.height - 1, curveDistance + 40, size.height);
    path.lineTo(size.width, size.height);

    path.lineTo(size.width, 0);

    //for  new modification
    path.lineTo(0, 0);

    //for older modification
    // path.lineTo(curveDistance, 0);
    // path.quadraticBezierTo(1,. 1, 0, 0 + size.height * 0.25);
    // path.lineTo(0, size.height * 0.4);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class MarkerCurvesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();
    path.moveTo(0.8 * size.width, 0);
    path.lineTo(0.7 * size.width, 0.35 * size.height);
    path.quadraticBezierTo(
        size.width * 0.85, size.height * 0.70, size.width, size.height * 0.65);
    path.lineTo(size.width, 0.25 * size.height);
    path.lineTo(size.width * 0.9, 0);

    path.close();

    paint.color = Colors.black;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this; //return true for custom clipper.
  }
}
