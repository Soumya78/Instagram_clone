import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/state/image_upload/model/exceptions/tofile.dart';

class Imagepickerhelper {
  static final ImagePicker _imagePicker = ImagePicker();

  static Future<File?> pickimagefromgallery() =>
      _imagePicker.pickImage(source: ImageSource.gallery).toFile();
  static Future<File?> pickvediofromgallery() =>
      _imagePicker.pickVideo(source: ImageSource.gallery).toFile();
}

