import 'package:flutter/foundation.dart' show immutable;

typedef CloseLoadingScreen = bool Function();
typedef UpdateLoadingScreen = bool Function(String text);

@immutable
class LoadingScreenController {
  final CloseLoadingScreen closeloadingscreen;
  final UpdateLoadingScreen updateloadingscreen;

  const LoadingScreenController(
      {required this.closeloadingscreen, required this.updateloadingscreen});
}
