import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/state/auth/providers/user_id_provider.dart';
import 'package:instagram_clone/state/constants/firebase_collection_name.dart';
import 'package:instagram_clone/state/constants/firebase_field_name.dart';
import 'package:instagram_clone/state/image_upload/model/typedef/post_id.dart';

final haslikedprovider =
    StreamProvider.family.autoDispose<bool, PostId>((ref, PostId postid) {
  final userid = ref.watch(useridprovider);
  if (userid == null) {
    return Stream<bool>.value(false);
  }
  final controller = StreamController<bool>();
  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.likes)
      .where(FirebaseFieldName.postid, isEqualTo: postid)
      .where(FirebaseFieldName.userid, isEqualTo: userid)
      .snapshots()
      .listen((snapshots) {
    if (snapshots.docs.isNotEmpty) {
      controller.add(true);
    } else {
      controller.add(false);
    }
  });
  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });
  return controller.stream;
});
