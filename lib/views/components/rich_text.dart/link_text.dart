import 'package:flutter/foundation.dart' show VoidCallback;
import 'package:instagram_clone/views/components/rich_text.dart/base_text.dart';

class LinkText extends BaseText {
  final VoidCallback onTapped;
  const LinkText({
    required this.onTapped,
    required super.text,
    super.style,
  });
}
