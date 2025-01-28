import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/state/constants/firebase_collection_name.dart';
import 'package:instagram_clone/state/constants/firebase_field_name.dart';
import 'package:instagram_clone/state/posts/providers/typedefs/search_term.dart';
import 'package:instagram_clone/state/typedef/post/post.dart';

final postbysearchtermprovider = StreamProvider.family
    .autoDispose<Iterable<Post>, SearchTerm>((ref, SearchTerm searchterm) {
  final controller = StreamController<Iterable<Post>>();
  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.posts)
      .orderBy(FirebaseFieldName.createdAt, descending: true)
      .snapshots()
      .listen((snapshot) {
    final post = snapshot.docs
        .map((doc) => Post(postid: doc.id, json: doc.data()))
        .where(
          (post) => post.message.toLowerCase().contains(
                searchterm.toLowerCase(),
              ),
        );
    controller.sink.add(post);
  });

  ref.onDispose(() {
    controller.close();
  });
  return controller.stream;
});
