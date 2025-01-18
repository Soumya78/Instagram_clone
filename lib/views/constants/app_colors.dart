import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart' show Colors;
import 'package:instagram_clone/extensions/string/ashtmlcolortocolor.dart';



@immutable
class AppColors {
  static final loginButtonColor = '#cfc9c2'.htmlColortoClor();
  static const loginButtonTextColor = Colors.black;
  static final googleColor = '#4285F4'.htmlColortoClor();
  static final facebookColor = '#3b5998'.htmlColortoClor();
  const AppColors._();
}