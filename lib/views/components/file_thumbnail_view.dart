import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgramclonexyz/state/image_upload/models/image_with_aspect_ratio.dart';
import 'package:instantgramclonexyz/state/image_upload/models/thumbnail_request.dart';
import 'package:instantgramclonexyz/state/image_upload/providers/thumbnail_provider.dart';
import 'package:instantgramclonexyz/views/components/animations/loading_animation.dart';
import 'package:instantgramclonexyz/views/components/animations/small_error_animation.dart';

class FileThumbnailView extends ConsumerWidget {
  final ThumbnailRequest request;

  const FileThumbnailView({
    required this.request,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<ImageWithAspectRatio> thumbnail =
        ref.watch(thumbnailProvider(request));
    return thumbnail.when(data: (imageWithAsepctRatio) {
      return AspectRatio(
        aspectRatio: imageWithAsepctRatio.aspectRatio,
        child: imageWithAsepctRatio.image,
      );
    }, error: (error, stackTrace) {
      return const SmallErrorAnimationView();
    }, loading: () {
      return const LoadingAnimationView();
    });
  }
}
