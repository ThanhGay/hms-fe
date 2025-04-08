import 'package:flutter/material.dart';

class TextPoppins extends StatelessWidget {
  final String title;
  final double size;
  final FontWeight weight;
  final Color? color;
  const TextPoppins(
      {super.key,
      required this.title,
      required this.size,
      this.weight = FontWeight.w500,
      this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: TextStyle(
            color: color,
            fontSize: size,
            fontFamily: 'Poppins',
            fontWeight: weight));
  }
}
