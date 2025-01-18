import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/state/comments/typedef/model/comment_payload.dart';
import 'package:instagram_clone/state/constants/firebase_collection_name.dart';
import 'package:instagram_clone/state/image_upload/model/typedef/is_loading.dart';
import 'package:instagram_clone/state/image_upload/model/typedef/post_id.dart';

import '../../../typedef/post/user_id.dart';

class Sendcommentnotifier extends StateNotifier<Isloading> {
  Sendcommentnotifier():super(false);

  set isloading(bool value) => state = value;

  Future<bool> sendcomment(
      {required Userid userid,
      required PostId postid,
      required String comment}) async {
    isloading = true;
    final payload =
        CommentPayload(fromUserId: userid, onPostId: postid, comment: comment);

    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.comments)
          .add(payload);
      return true;
    } catch (_) {
      return false;
    } finally {
      isloading = false;
    }
  }
}
