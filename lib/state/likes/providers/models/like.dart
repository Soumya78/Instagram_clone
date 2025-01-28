import 'dart:collection';

import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone/state/constants/firebase_field_name.dart';
import 'package:instagram_clone/state/image_upload/model/typedef/post_id.dart';
import 'package:instagram_clone/state/typedef/post/user_id.dart';

@immutable
class Like extends MapView<String, String> {
  Like(
      {required PostId postid,
      required Userid userid,
      required DateTime datetime})
      : super({
          FirebaseFieldName.postid: postid,
          FirebaseFieldName.userid: userid,
          FirebaseFieldName.date: datetime.toIso8601String(),
        });
}
