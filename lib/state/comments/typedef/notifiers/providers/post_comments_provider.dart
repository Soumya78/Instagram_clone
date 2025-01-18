import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/state/comments/typedef/extensions/comment_sorting_by_request.dart';
import 'package:instagram_clone/state/comments/typedef/model/comment.dart';
import 'package:instagram_clone/state/comments/typedef/model/postcommentsrequest.dart';
import 'package:instagram_clone/state/constants/firebase_field_name.dart';

final postcommentprovider = StreamProvider.family
    .autoDispose<Iterable<Comment>, RequestForPostAndComments>(
        (ref, RequestForPostAndComments request) {
  final controller = StreamController<Iterable<Comment>>();
  final sub = FirebaseFirestore.instance
      .collection(FirebaseFieldName.commment)
      .where(FirebaseFieldName.postid, isEqualTo: request.postid)
      .snapshots()
      .listen((snapshot) {
    final doc = snapshot.docs;
    print(doc.length);

    print("Limited docs started");
    final limiteddocs = request.limit != null ? doc.take(request.limit!) : doc;
    print("Limited docs ended ");
    print(limiteddocs.length);

    print("Comments started");

    final comments = limiteddocs
        .where((doc) => !doc.metadata.hasPendingWrites)
        .map((document) {
      print("Comments ended");

      return Comment(document.data(), id: document.id);

    });
    print("These are the comments" );
    print("Result started");
    final result = comments.applysortingfrom(request);
    controller.sink.add(result);
    print(result);
  },onError: (error){
    print("Error fetching comments: $error");
  });
  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });
  return controller.stream;
});
