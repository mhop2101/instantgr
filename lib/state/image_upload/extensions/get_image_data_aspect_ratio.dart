import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:instantgramclonexyz/state/image_upload/extensions/get_image_aspect_ratio.dart';

extension GetImageDataAspectRatio on Uint8List {
  Future<double> getAspectRatio() {
    final image = Image.memory(this);
    return image.getAspectRatio();
  }
}
