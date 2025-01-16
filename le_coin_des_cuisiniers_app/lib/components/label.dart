import 'package:flutter/material.dart';

class MyLabel extends StatelessWidget {
  final String labelContent; // Marked as final
  const MyLabel({super.key, required this.labelContent});

  @override
  Widget build(BuildContext context) {
    return Text(
      labelContent,
      textAlign: TextAlign.start,
      style: const TextStyle(
          color: Color.fromARGB(255, 70, 103, 71), fontWeight: FontWeight.bold),
    );
  }
}
