/*     This says: "I want to add a new ability
       to the Image widget in Flutter."
       Specifically, this ability is to calculate the
       aspect ratio of the image.

       This creates a method that will calculate the aspect ratio of the image.
       It’s an async function because we don’t immediately know the width and height of
       the image. We have to wait for the image to load.

       Think of a Completer as a magic box that lets you wait for something to finish.
       When the image finishes loading, the box will return the aspect ratio.

       */


import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as material
    show Image, ImageConfiguration, ImageStreamListener;

extension GetImageascpetration on material.Image {
  Future<double> getaspectration() async {
    final completer = Completer<double>();
    image.resolve(material.ImageConfiguration()).addListener(
      material.ImageStreamListener(
        (ImageInfo imageinfo, bool syncronouscall) {
          final aspectratio = imageinfo.image.width / imageinfo.image.height;
          imageinfo.image.dispose();
          completer.complete(aspectratio);
        },
      ),
    );
    return completer.future;
  }
}
