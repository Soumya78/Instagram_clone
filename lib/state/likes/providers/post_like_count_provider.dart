import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/state/constants/firebase_collection_name.dart';
import 'package:instagram_clone/state/constants/firebase_field_name.dart';
import 'package:instagram_clone/state/image_upload/model/typedef/post_id.dart';

final postlikescountprovider =
    StreamProvider.family.autoDispose<int, PostId>((ref, PostId postid) {
  final controller = StreamController<int>.broadcast();
  controller.onListen = () {
    controller.sink.add(0);
  };
  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.likes)
      .where(FirebaseFieldName.postid, isEqualTo: postid)
      .snapshots()
      .listen((snapshots) {
    controller.sink.add(snapshots.docs.length);
  });
  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });
  return controller.stream;
});
