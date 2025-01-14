import 'package:flutter/material.dart';
import 'package:instantgramclonexyz/state/posts/models/post.dart';
import 'package:instantgramclonexyz/views/components/post/post_thumbnail_view.dart';
import 'package:instantgramclonexyz/views/post_details/post_details_view.dart';

class PostSliverGridView extends StatelessWidget {
  final Iterable<Post> posts;
  const PostSliverGridView({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      delegate: SliverChildBuilderDelegate(childCount: posts.length,
          (context, index) {
        final post = posts.elementAt(index);
        return PostThumbnailView(
          onTapped: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => PostDetailsView(
                  post: post,
                ),
              ),
            );
          },
          post: post,
        );
      }),
    );
  }
}
