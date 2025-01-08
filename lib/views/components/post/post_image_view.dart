import 'package:flutter/material.dart';
import 'package:instantgramclonexyz/state/posts/models/post.dart';

class PostImageView extends StatelessWidget {
  final Post post;
  const PostImageView({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: post.aspectRatio,
      child: Image.network(
        post.fileUrl,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
