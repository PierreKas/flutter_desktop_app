import 'package:flutter/material.dart';

class MyTextHeader extends StatelessWidget {
  final String content;
  const MyTextHeader({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: Color.fromARGB(255, 70, 103, 71)),
    );
  }
}
