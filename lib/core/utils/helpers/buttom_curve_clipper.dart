
// Custom Clipper to draw the smooth concave downward curve

import 'package:flutter/material.dart';

class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    
    // Start at top-left
    path.lineTo(0, size.height * 0.78); 
    
    // Control point and end point for the quadratic bezier curve
    var firstControlPoint = Offset(size.width / 2, size.height * 1.12);
    var firstEndPoint = Offset(size.width, size.height * 0.78);
    
    path.quadraticBezierTo(
      firstControlPoint.dx, 
      firstControlPoint.dy, 
      firstEndPoint.dx, 
      firstEndPoint.dy
    );

    // Close the path to the top right and back to start
    path.lineTo(size.width, 0);
    path.close();
    
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}