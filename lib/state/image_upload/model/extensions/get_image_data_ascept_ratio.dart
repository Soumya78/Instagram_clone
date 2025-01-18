import 'package:flutter/foundation.dart' show Uint8List;
import 'package:flutter/material.dart' as material show Image;
import 'package:instagram_clone/state/image_upload/model/extensions/get_aspect_ratio.dart';

extension GetImageDataAsceptRatio on Uint8List {
  Future<double> getasceptratio() {
    final image = material.Image.memory(this);
    return image.getaspectration();
  }
}
