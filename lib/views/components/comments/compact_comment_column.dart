import 'package:flutter/material.dart';
import 'package:instantgramclonexyz/state/comments/models/comment.dart';
import 'package:instantgramclonexyz/views/components/comments/compact_comment_tile.dart';

class CompactCommentColumn extends StatelessWidget {
  final Iterable<Comment> comments;
  const CompactCommentColumn({super.key, required this.comments});

  @override
  Widget build(BuildContext context) {
    if (comments.isEmpty) {
      return const SizedBox.shrink();
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: comments.map(
            (comment) {
              return CompactCommentTile(
                comment: comment,
              );
            },
          ).toList(),
        ),
      );
    }
  }
}
