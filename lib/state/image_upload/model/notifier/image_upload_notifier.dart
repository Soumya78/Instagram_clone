import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/state/constants/firebase_collection_name.dart';
import 'package:instagram_clone/state/image_upload/model/constants/constants.dart';
import 'package:instagram_clone/state/image_upload/model/exceptions/could_not_build_thumbnail_exception.dart';
import 'package:instagram_clone/state/image_upload/model/extensions/get_collection_name%20from_file_type.dart';
import 'package:instagram_clone/state/image_upload/model/extensions/get_image_data_ascept_ratio.dart';
import 'package:instagram_clone/state/image_upload/model/typedef/is_loading.dart';
import 'package:instagram_clone/state/post_settings/models/postsettings.dart';
import 'package:instagram_clone/state/posts/providers/models/post_payload.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../typedef/post/user_id.dart';
import '../filetype.dart';
import 'package:image/image.dart' as img;
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Imageuploadnotifier extends StateNotifier<Isloading> {
  Imageuploadnotifier() : super(false);

  set isloading(bool value) => state = value;

  Future<bool> upload({
    required File file,
    required FileType filetype,
    required String message,
    required Map<Postsettings, bool> postsettings,
    required Userid userid,
  }) async {
    isloading = true;
    late Uint8List thumbnailluint8ist;
    switch (filetype) {
      case FileType.image:
        final finalimage = img.decodeImage(file.readAsBytesSync());

        print(finalimage?.format);

        if (finalimage == null) {
          isloading = false;
          return false;
        }
        final thumbnail =
            img.copyResize(finalimage, width: Constants.imagethumbnailwidth);

        final thumbnaildata = img.encodePng(thumbnail);

        thumbnailluint8ist = Uint8List.fromList(thumbnaildata);
        print('Size of thumbnail in bytes: ${thumbnailluint8ist.length}');

        break;

      case FileType.video:
        final thumb = await VideoThumbnail.thumbnailData(
            video: file.path,
            imageFormat: ImageFormat.JPEG,
            maxHeight: Constants.vediothumbnailmaxheight,
            quality: Constants.vediothumbnailquality);
        if (thumb == null) {
          isloading = false;
          throw CouldnotbuildException();
        } else {
          thumbnailluint8ist = thumb;
        }
        break;
    }
    final thumbnailaspectratio = await thumbnailluint8ist.getasceptratio();
    final filename = const Uuid().v4();

    final thumbnailref = FirebaseStorage.instance
        .ref()
        .child(userid)
        .child(FirebaseCollectionName.thumbanails)
        .child(filename);
    print("The file is $file");

     final originalFileref = FirebaseStorage.instance
        .ref()
        .child(userid)
        .child(filetype.collectionname)
        .child(filename);


    print("The file name is $filename");


    try {
      final thumbnailupoadtask = await thumbnailref.putData(thumbnailluint8ist);
      print("........");

      final thumbnailStorageid = thumbnailupoadtask.ref.name;
      print("...........");
      print(file);
      print("FileType: $filetype, Collection Name: ${filetype.collectionname}");
      print("Generated Path: $userid/${filetype.collectionname}/$filename");
      print(userid);
   // I changed the putfile to putData and it worked for both andorid and ios
      final originalFileuploadtask = await originalFileref.putData(
          file.readAsBytesSync()); // Specify only essential metadata

      print(
          '....****###: Uploading originalFileuploadtask complted $originalFileuploadtask');

      final originalStorageid = originalFileuploadtask.ref.name;
      print('....****###%%');
      print('FileType value: $filetype ');

      final postpayload = PostPayload(
          userid: userid,
          message: message,
          thumbnailurl: await thumbnailref.getDownloadURL(),
          fileurl: await originalFileref.getDownloadURL(),
          filetype: filetype.name,
          filename: filename,
          ascpetratio: thumbnailaspectratio,
          thumbnailstorageid: thumbnailStorageid,
          originalstorageid: originalStorageid,
          postsettings: postsettings);
      print(postpayload);
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.posts)
          .add(postpayload);
    } catch (e,stacktrace) {
      print('Error occurred: $e');
      if (e is FirebaseException) {
        print("Error code: ${e.code}");
        print("Error message: ${e.message}");
      }

      return false;
    } finally {
      isloading = false;
    }
    return true;
  }
}
