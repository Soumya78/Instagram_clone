import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;

import '../../../constants/firebase_field_name.dart';
import '../../../image_upload/model/typedef/post_id.dart';
import '../../../typedef/post/user_id.dart';
import '../comment_id.dart';

@immutable
class Comment {
  final Commentid id;
  final String comments;
  final DateTime createdAt;
  final Userid fromUserId;
  final PostId onPostId;

  Comment(Map<String, dynamic> json, {required this.id})
      : comments = json[FirebaseFieldName.commment] ?? '',
        createdAt = (json[FirebaseFieldName.createdAt ] as Timestamp).toDate() ,
        fromUserId = json[FirebaseFieldName.userid ] ?? '',
        onPostId = json[FirebaseFieldName.postid ] ?? '';
  // @override
  // String toString() {
  //   return 'Comment(id: $id, comments: $comment, createdAt: $createdAt, fromUserId: $fromUserId, onPostId: $onPostId)';
  // }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Comment &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          comments == other.comments &&
          createdAt == other.createdAt &&
          fromUserId == other.fromUserId &&
          onPostId == other.onPostId;

  @override
  int get hashCode => Object.hashAll(
        [
          id,
          comments,
          createdAt,
          fromUserId,
          onPostId,
        ],
      );
}
