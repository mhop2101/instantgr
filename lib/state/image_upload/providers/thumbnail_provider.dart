import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgramclonexyz/state/image_upload/exceptions/could_not_build_thumbnail_expception.dart';
import 'package:instantgramclonexyz/state/image_upload/extensions/get_image_aspect_ratio.dart';
import 'package:instantgramclonexyz/state/image_upload/models/file_type.dart';
import 'package:instantgramclonexyz/state/image_upload/models/image_with_aspect_ratio.dart';
import 'package:instantgramclonexyz/state/image_upload/models/thumbnail_request.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';

final thumbnailProvider = FutureProvider.family
    .autoDispose<ImageWithAspectRatio, ThumbnailRequest>((ref, request) async {
  final Image image;

  switch (request.fileType) {
    case FileType.image:
      image = Image.file(
        request.file,
        fit: BoxFit.fitHeight,
      );
      break;
    case FileType.video:
      final videoThumbnail = await VideoThumbnail.thumbnailData(
        video: request.file.path,
        maxWidth: 128,
        quality: 25,
      );

      if (videoThumbnail == null) {
        throw const CouldNotBuildThumbnailExpception();
      }

      image = Image.memory(
        videoThumbnail,
        fit: BoxFit.fitHeight,
      );

      break;
  }
  final aspectRatio = await image.getAspectRatio();
  return ImageWithAspectRatio(
    image: image,
    aspectRatio: aspectRatio,
  );
});
