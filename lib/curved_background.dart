import 'package:flutter/material.dart';

class CurvedBackground extends StatelessWidget {
  final double screenHeight;

  const CurvedBackground({Key? key, required this.screenHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BottomShapeClipper(),
      child: Container(
        height: screenHeight * 0.5,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.brown[800]!, // Upper color
              Colors.white, // Lower color
            ],
            stops: [0.5, 0.5], // Set transition point
          ),
        ),
      ),
    );
  }
}

class BottomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    Offset curveStartPoint = Offset(0, size.height * 0.85);
    Offset curveControlPoint1 = Offset(size.width * 0.25, size.height * 0.9);
    Offset curveControlPoint2 = Offset(size.width * 0.75, size.height * 0.8);
    Offset curveEndPoint = Offset(size.width, size.height * 0.85);
    path.lineTo(curveStartPoint.dx, curveStartPoint.dy);
    path.cubicTo(
        curveControlPoint1.dx,
        curveControlPoint1.dy,
        curveControlPoint2.dx,
        curveControlPoint2.dy,
        curveEndPoint.dx,
        curveEndPoint.dy);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
