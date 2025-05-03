import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Colors.orange,
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Poppins',
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: Colors.grey[900],
      scaffoldBackgroundColor: Colors.black,
      fontFamily: 'Poppins',
    );
  }
}

class ColorConstants {
  static final primaryColor = Color.fromRGBO(255, 90, 95, 1);
  // static final secondaryColor = Color.fromRGBO(0, 50, 250, 1);
  static final secondaryColor = Colors.blue;
  static final textDefaultColor = Colors.black;
  static final textGrayColor = Colors.grey.shade400;
  static final borderGrayColor = Colors.grey.shade300;
}
