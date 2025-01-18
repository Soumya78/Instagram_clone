import 'package:flutter/material.dart';
import 'remove_all.dart';

extension Ashtmlcolortocolor on String {
  Color htmlColortoClor() => Color(
        int.parse(
          removeall(['0x', '#']).padLeft(8,'ff'),
          radix: 16,
        ),
      );
}
