import 'package:flutter/cupertino.dart';

extension DissmissKeyboard on Widget{
  void dissmissKeyboard() => FocusManager.instance.primaryFocus?.unfocus();
}
