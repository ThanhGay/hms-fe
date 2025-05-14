import 'package:flutter/material.dart';

class BuildSectionTitle extends StatelessWidget {
  final String title;

  const BuildSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return 
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
