import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_clone/state/image_upload/model/typedef/post_id.dart';
import 'package:instagram_clone/state/typedef/post/user_id.dart';

import '../../../constants/firebase_field_name.dart';


@immutable
class CommentPayload extends MapView<String, dynamic> {
  CommentPayload({
    required Userid fromUserId,
    required PostId onPostId,
    required String comment,
  }) : super(
    {
      FirebaseFieldName.userid: fromUserId,
      FirebaseFieldName.postid: onPostId,
      FirebaseFieldName.commment: comment,
      FirebaseFieldName.createdAt: FieldValue.serverTimestamp(),
    },
  );
}