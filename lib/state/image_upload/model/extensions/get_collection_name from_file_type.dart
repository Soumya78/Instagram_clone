import 'package:instagram_clone/state/image_upload/model/filetype.dart';

extension Collectiontype on FileType{
  String get collectionname{
    switch(this){
      case FileType.image:
        return "images";
      case FileType.video:
        return "videos";
      default:
        throw Exception('Unknown FileType: $this');
    }
  }
}