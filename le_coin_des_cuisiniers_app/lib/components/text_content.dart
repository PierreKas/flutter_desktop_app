import 'package:flutter/material.dart';

class MyTextContent extends StatelessWidget {
  final String content;
  const MyTextContent({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Text(content,
        style: const TextStyle(
          fontSize: 25,
          color: Color.fromARGB(255, 70, 103, 71),
          // color: Colors.white,
          fontWeight: FontWeight.w300,
        ));
  }
}
