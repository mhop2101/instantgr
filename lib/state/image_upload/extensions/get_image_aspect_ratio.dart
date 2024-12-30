import 'dart:async';

import 'package:flutter/material.dart';

extension GetImageAspectRatio on Image {
  Future<double> getAspectRatio() async {
    final Completer<double> completer = Completer();
    image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo info, bool _) {
          final double aspectRatio = info.image.width / info.image.height;
          info.image.dispose();
          completer.complete(aspectRatio);
        },
      ),
    );
    return completer.future;
  }
}
