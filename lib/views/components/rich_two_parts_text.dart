import 'package:flutter/material.dart';

class RichTwoPartsText extends StatelessWidget {
  final String leftpart;

  final String rightpart;

  const RichTwoPartsText(
      {super.key, required this.leftpart, required this.rightpart});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          style: const TextStyle(color: Colors.white70, height: 1.5),
          children: [
            TextSpan(
                text: leftpart,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: ' $rightpart'),
          ]),
    );
  }
}
