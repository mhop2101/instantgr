import 'dart:io';

import 'package:get_thumbnail_video/video_thumbnail.dart';

extension ToFile on Future<XFile?> {
  Future<File?> toFile() =>
      then((file) => file?.path != null ? File(file!.path) : null);
}
