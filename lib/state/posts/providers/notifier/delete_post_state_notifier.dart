import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/state/constants/firebase_collection_name.dart';
import 'package:instagram_clone/state/constants/firebase_field_name.dart';
import 'package:instagram_clone/state/image_upload/model/extensions/get_collection_name%20from_file_type.dart';
import 'package:instagram_clone/state/image_upload/model/typedef/is_loading.dart';
import 'package:instagram_clone/state/image_upload/model/typedef/post_id.dart';
import 'package:instagram_clone/state/typedef/post/post.dart';

class Deletepoststatenotfier extends StateNotifier<Isloading> {
  Deletepoststatenotfier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> deletepost({required Post post}) async {
    try {
      await FirebaseStorage.instance
          .ref()
          .child(post.Userid)
          .child(FirebaseCollectionName.thumbanails)
          .child(post.thumbnailstorageid)
          .delete();
      // delete the images and vedios

      await FirebaseStorage.instance
          .ref()
          .child(post.Userid)
          .child(post.filetype.collectionname)
          .child(post.originalfilestorage)
          .delete();

      await _deletealldocuments(
          postid: post.postid, incollection: FirebaseCollectionName.comments);

      await _deletealldocuments(
          postid: post.postid, incollection: FirebaseCollectionName.likes);
      final inpostcollection = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.posts)
          .where(FieldPath.documentId, isEqualTo: post.postid)
          .limit(1)
          .get();

      for (final post in inpostcollection.docs) {
        await post.reference.delete();
      }

      return true;
    } catch (_) {
      return false;
    } finally {
      return true;
    }
  }

  Future<void> _deletealldocuments({
    required PostId postid,
    required String incollection,
  }) {
    return FirebaseFirestore.instance.runTransaction(
        maxAttempts: 3,
        timeout: const Duration(seconds: 20), (transaction) async {
      final query = await FirebaseFirestore.instance
          .collection(incollection)
          .where(FirebaseFieldName.postid, isEqualTo: postid)
          .get();
      for (final doc in query.docs) {
        transaction.delete(doc.reference);
      }
    });
  }
}
