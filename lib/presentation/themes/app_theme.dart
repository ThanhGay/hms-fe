import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Colors.orange,
      scaffoldBackgroundColor: Colors.white,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: Colors.grey[900],
      scaffoldBackgroundColor: Colors.black,
    );
  }
}
