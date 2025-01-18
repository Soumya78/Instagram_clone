import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/typedef/post/user_id.dart';
import 'package:instagram_clone/state/user_info/models/user_info_model.dart';


import '../../constants/firebase_collection_name.dart';
import '../../constants/firebase_field_name.dart';

final userInfoModelProvider =
StreamProvider.family.autoDispose<Userinfomodel, Userid>(
      (ref, Userid userId) {
    final controller = StreamController<Userinfomodel>();

    final sub = FirebaseFirestore.instance
        .collection(
      FirebaseCollectionName.users,
    )
        .where(
      FirebaseFieldName.userid,
      isEqualTo: userId,
    )
        .limit(1)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        final doc = snapshot.docs.first;
        final json = doc.data();
        final userInfoModel = Userinfomodel.fromJson(json, userid: userId);
        controller.add(userInfoModel);
      }
    });

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    return controller.stream;
  },
);