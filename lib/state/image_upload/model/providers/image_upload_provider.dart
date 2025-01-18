import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/state/image_upload/model/notifier/image_upload_notifier.dart';
import 'package:instagram_clone/state/image_upload/model/typedef/is_loading.dart';

final imageUplaodProvider =
    StateNotifierProvider<Imageuploadnotifier, Isloading>(
        (ref) => Imageuploadnotifier());
