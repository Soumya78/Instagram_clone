import 'dart:collection' show MapView;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone/state/image_upload/model/filetype.dart';
import 'package:instagram_clone/state/post_settings/models/postsettings.dart';
import 'package:instagram_clone/state/typedef/post/postkey.dart';
import 'package:instagram_clone/state/typedef/post/user_id.dart';

@immutable
class PostPayload extends MapView<String, dynamic> {
  PostPayload({
    required Userid userid,
    required String message,
    required String thumbnailurl,
    required String fileurl,
    required String filetype,
    required String filename,
    required double ascpetratio,
    required String thumbnailstorageid,
    required String originalstorageid,
    required Map<Postsettings, bool> postsettings,
  }) : super({
          PostKey.userId: userid,
          PostKey.message: message,
          PostKey.createdAt: FieldValue.serverTimestamp(),
          PostKey.thumbnailUrl: thumbnailurl,
          PostKey.fileUrl: fileurl,
          PostKey.fileType: filetype,
          PostKey.fileName: filename,
          PostKey.aspectRatio: ascpetratio,
          PostKey.thumbnailStorageId: thumbnailstorageid,
          PostKey.originalFileStorageId: originalstorageid,
          PostKey.postSettings: {
            for (final postsetting in postsettings.entries)
              postsetting.key.storagekey: postsetting.value
          }
        });
}
