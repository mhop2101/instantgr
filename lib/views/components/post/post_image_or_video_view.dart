import 'package:flutter/material.dart';
import 'package:instantgramclonexyz/state/image_upload/models/file_type.dart';
import 'package:instantgramclonexyz/state/posts/models/post.dart';
import 'package:instantgramclonexyz/views/components/post/post_image_view.dart';
import 'package:instantgramclonexyz/views/components/post/post_video_view.dart';

class PostImageOrVideoView extends StatelessWidget {
  final Post post;
  const PostImageOrVideoView({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return () {
      if (post.fileType == FileType.video) {
        return PostVideoView(post: post);
      } else {
        return PostImageView(post: post);
      }
    }();
  }
}
