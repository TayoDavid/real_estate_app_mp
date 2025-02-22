import 'package:flutter/material.dart';

class CirclePath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    var radius = size.width / 2;
    var center = Offset(radius, radius);
    final rect = Rect.fromCircle(center: center, radius: radius);
    path.addOval(rect);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
