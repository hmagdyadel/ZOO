import 'package:flutter/material.dart';

class AppTheme {
  static const TextStyle display1 = TextStyle(
      fontFamily: 'Ranga',
      fontSize: 34,
      color: Colors.deepOrange,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.2);
  static const TextStyle display2 = TextStyle(
      fontFamily: 'Ranga',
      color: Colors.pink,
      fontSize: 32,
      fontWeight: FontWeight.normal,
      letterSpacing: 1.1);
  static final TextStyle heading = TextStyle(
      fontFamily: 'Ranga',
      fontSize: 38,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.2,
      color: Colors.teal.withOpacity(0.8));
  static final TextStyle heading1 = TextStyle(
      fontFamily: 'Ranga',
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: Colors.teal.withOpacity(0.8));
  static final TextStyle subHeading = TextStyle(
    inherit: true,
    fontFamily: 'Ranga',
    color: Colors.white.withOpacity(0.8),
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle description = TextStyle(
    inherit: true,
    fontFamily: 'Ranga',
    color: Colors.white.withOpacity(0.8),
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );
}
