import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/state/constants/firebase_collection_name.dart';
import 'package:instagram_clone/state/image_upload/model/typedef/is_loading.dart';

import '../comment_id.dart';

class DeleteStateNotifier extends StateNotifier<Isloading> {
  DeleteStateNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> deletecomment({required Commentid commentid}) async {
    try {
      isLoading = true;
      final query = FirebaseFirestore.instance
          .collection(FirebaseCollectionName.comments)
          .where(FieldPath.documentId, isEqualTo: commentid)
          .limit(1)
          .get();
      await query.then((query) async{
        for(final  doc in query.docs){
        await doc.reference.delete();
        }

      });
      return true ;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
