import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone/state/image_upload/model/filetype.dart';
import 'package:instagram_clone/state/post_settings/models/postsettings.dart';
import 'package:instagram_clone/state/typedef/post/postkey.dart';

@immutable
class Post {
  final String postid;
  final String Userid;
  final String message;
  final DateTime createdate;
  final String thumbnail;
  final String fileurl;
  final FileType filetype;
  final String filename;
  final double aspectratio;
  final String thumbnailstorageid;
  final String originalfilestorage;
  final Map<Postsettings, bool> postsettings;
  Post({
    required this.postid,
    required Map<String, dynamic> json,
  })  : Userid = json[PostKey.userId],
        message = json[PostKey.message],
        createdate = (json[PostKey.createdAt] as Timestamp).toDate(),
        thumbnail = json[PostKey.thumbnailUrl],
        fileurl = json[PostKey.fileUrl],
        filetype = FileType.values.firstWhere(
            (filetype) => filetype.name == json[PostKey.fileType],
            orElse: () => FileType.image),
        filename = json[PostKey.fileName],
        aspectratio = json[PostKey.aspectRatio],
        thumbnailstorageid = json[PostKey.thumbnailStorageId],
        originalfilestorage = json[PostKey.originalFileStorageId],
        postsettings = {
          for (final entry in json[PostKey.postSettings].entries)
            Postsettings.values.firstWhere(
                    (postsettings) => postsettings.storagekey == entry.key):
                entry.value,
        };
        bool get allowlikes => postsettings[Postsettings.allowlikes] ?? false;
        bool get allowcomments => postsettings[Postsettings.allowcomments] ?? false;
}
