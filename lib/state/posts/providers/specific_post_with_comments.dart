import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/state/comments/typedef/extensions/comment_sorting_by_request.dart';
import 'package:instagram_clone/state/comments/typedef/model/comment.dart';
import 'package:instagram_clone/state/comments/typedef/model/post_with_comment_model.dart';
import 'package:instagram_clone/state/comments/typedef/model/postcommentsrequest.dart';
import 'package:instagram_clone/state/constants/firebase_collection_name.dart';
import 'package:instagram_clone/state/constants/firebase_field_name.dart';
import 'package:instagram_clone/state/typedef/post/post.dart';

final specificpostwithcommentprovider = StreamProvider.family
    .autoDispose<PostwithcommentModel, RequestForPostAndComments>(
  (ref, RequestForPostAndComments request) {
    final controller = StreamController<PostwithcommentModel>();
    Post? post;
    Iterable<Comment>? comments;

    void notify() {
      final localpost = post;
      if (localpost == null) {
        return;
      }
      final outputcomments = (comments ?? []).applysortingfrom(request);
      final result =
          PostwithcommentModel(post: localpost, comment: outputcomments);
      controller.sink.add(result);
    }

    final postsub = FirebaseFirestore.instance
        .collection(
          FirebaseCollectionName.posts,
        )
        .where(FieldPath.documentId, isEqualTo: request.postid)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.docs.isEmpty) {
        post = null;
        comments = null;
        notify();
        return;
      }
      final docs = snapshot.docs.first;
      if (docs.metadata.hasPendingWrites) {
        return;
      }
      post = Post(
        postid: docs.id,
        json: docs.data(),
      );
      notify();
    });
    final commentsquery = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.comments)
        .where(FirebaseFieldName.postid, isEqualTo: request.postid)
        .orderBy(FirebaseFieldName.createdAt, descending: true);
    final limitedcommentsquery = request.limit != null
        ? commentsquery.limit(request.limit!)
        : commentsquery;

    final commentsub = limitedcommentsquery.snapshots().listen((snapshots) {
      comments = snapshots.docs
          .where((doc) => !doc.metadata.hasPendingWrites)
          .map(
            (doc) => Comment(doc.data(), id: doc.id),
          )
          .toList();
      notify();
    });
    ref.onDispose(() {
      postsub.cancel();
      commentsub.cancel();
      controller.close();
    });
    return controller.stream;
  },
);
