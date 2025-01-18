/*
Let’s break it down step by step like you have only two brain cells (keeping it super simple):

What’s Happening?
You’re using Riverpod to create something called a FutureProvider.family.autoDispose.
It’s a tool to fetch or generate data (in this case, a thumbnail with aspect ratio) when needed, and it cleans up when it’s no longer used.

The Pieces
1. thumbnail
This is the name of your provider.
Think of it as a box that gives you a specific thumbnail when you ask for it.

2. FutureProvider.family
FutureProvider: It’s a provider for asynchronous (future-based) data. You use it when you don’t immediately have the data (like downloading or calculating something).
.family: It lets you pass in a parameter to the provider, so you can fetch or generate different data based on the input. Here, the parameter is Thumbnailrequest.
3. autoDispose
This is like saying: "Clean up after yourself when no one needs this data anymore."
It frees memory and resources, keeping the app efficient.
4. ImagewithAspectration
This is the type of data your provider will return.
It’s an object (probably a custom class) that contains an image and its aspect ratio.

5. Thumbnailrequest
This is the parameter your provider accepts.
It’s probably an object containing details about the image you want, like:

File path
Type of file (JPEG, PNG, etc.)*/

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/state/image_upload/model/exceptions/could_not_build_thumbnail_exception.dart';
import 'package:instagram_clone/state/image_upload/model/extensions/get_aspect_ratio.dart';
import 'package:instagram_clone/state/image_upload/model/filetype.dart';
import 'package:instagram_clone/state/image_upload/model/imagewithaspectratio.dart';
import 'package:instagram_clone/state/image_upload/model/thumbnailrequest.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

final thumbnailprovider = FutureProvider.family
    .autoDispose<ImagewithAspectration, Thumbnailrequest>(
        (ref, Thumbnailrequest request) async {
  final Image image;
  switch (request.fileType) {
    case FileType.image:
      image = Image.file(
        request.file,
        fit: BoxFit.fitHeight,
      );
      break;
    // TODO: Handle this case.
    case FileType.video:
      final thumb = await VideoThumbnail.thumbnailData(
          video: request.file.path, imageFormat: ImageFormat.JPEG, quality: 75);
      if (thumb == null) {
        print('Failed to generate thumbnail for video at path: ${request.file.path}');
        throw CouldnotbuildException();
      } else {
        image = Image.memory(thumb, fit: BoxFit.fitHeight);
      }
      break; // TODO: Handle this case.
  }
  final aspectratio = await image.getaspectration();
  return ImagewithAspectration(image: image, aspectratio: aspectratio);
});
