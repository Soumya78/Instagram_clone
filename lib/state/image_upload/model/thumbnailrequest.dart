import 'dart:io';

import 'package:instagram_clone/state/image_upload/model/filetype.dart';

class Thumbnailrequest {
  final File file;

  final FileType fileType;

  const Thumbnailrequest({required this.file, required this.fileType});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||        // check if this and other are identical
      other is Thumbnailrequest &&   // if false check if other is equal to Thumbnailrequest
          runtimeType == other.runtimeType && //
          file == other.file &&
          fileType == other.fileType;

  @override
  // TODO: implement hashCode
  int get hashCode => Object.hashAll([runtimeType,fileType,file]);

}
