import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone/state/constants/firebase_collection_name.dart';
import 'package:instagram_clone/state/constants/firebase_field_name.dart';
import 'package:instagram_clone/state/typedef/post/user_id.dart';
import 'package:instagram_clone/state/user_info/models/user_info_payload.dart';

@immutable
class UserInfoStorage {
  const UserInfoStorage();
  Future<bool> saveuserinfo({
    required Userid uid,
    required String? email,
    required String? displayname,
  }) async {
    //first check if the user is already in the storage
    try {
      final userinfo = await FirebaseFirestore.instance
          .collection(
            FirebaseCollectionName.users,
          )
          .where(FirebaseFieldName.userid, isEqualTo: uid)
          .limit(1)
          .get();
      if (userinfo.docs.isNotEmpty) {
        await userinfo.docs.first.reference.update({
          FirebaseFieldName.email: email ?? '',
          FirebaseFieldName.displayname: displayname ?? '',
        });
        return true;
      }
      // We dont have this user information
      final payload =
          Userinfo(userid: uid, displayname: displayname, email: email);
      await FirebaseFirestore.instance
          .collection(
            FirebaseCollectionName.users,
          )
          .add(payload);
      return true;
    } catch (e) {
      return false;
    }
  }
}
