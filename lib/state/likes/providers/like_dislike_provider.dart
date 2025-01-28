import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/state/constants/firebase_collection_name.dart';
import 'package:instagram_clone/state/constants/firebase_field_name.dart';
import 'package:instagram_clone/state/likes/providers/models/like.dart';
import 'package:instagram_clone/state/likes/providers/models/like_dislike_model.dart';

final likedislikeprovider =
    FutureProvider.family.autoDispose<bool, LikedislikeRequest>(
  (ref, LikedislikeRequest request) async {
    final query = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.likes)
        .where(FirebaseFieldName.postid, isEqualTo: request.postid)
        .where(FirebaseFieldName.userid, isEqualTo: request.likedby)
        .get();

    final hasliked = await query.then((snapshot) => snapshot.docs.isNotEmpty);
    if (hasliked) {
      try {
        await query.then((snapshot) async {
          for (final docs in snapshot.docs) {
            await docs.reference.delete();
          }
        });
        return true;
      } catch (_) {
        return false;
      }
    } else {
      final like = Like(
          postid: request.postid,
          userid: request.likedby,
          datetime: DateTime.now());
      try {
        FirebaseFirestore.instance
            .collection(FirebaseCollectionName.likes)
            .add(like);
        return true;
      } catch (_) {
        return false;
      }
    }
  },
);
