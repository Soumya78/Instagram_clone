import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone/state/constants/firebase_field_name.dart';
import 'dart:collection' show MapView;

import 'package:instagram_clone/state/typedef/post/user_id.dart';

@immutable
class Userinfo extends MapView<String, String> {
  Userinfo(
      {required Userid userid,
      required String? displayname,
      required String? email})
      : super({
          FirebaseFieldName.userid: userid,
          FirebaseFieldName.displayname: displayname ?? '',
          FirebaseFieldName.email: email ?? ''
        });
}
