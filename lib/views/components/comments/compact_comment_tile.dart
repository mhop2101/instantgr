import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgramclonexyz/state/comments/models/comment.dart';
import 'package:instantgramclonexyz/state/user_info/providers/user_info_model_provider.dart';
import 'package:instantgramclonexyz/views/components/animations/small_error_animation.dart';
import 'package:instantgramclonexyz/views/components/rich_two_parts_text.dart';

class CompactCommentTile extends ConsumerWidget {
  final Comment comment;
  const CompactCommentTile({super.key, required this.comment});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userInfoModelProvider(comment.fromUserId));
    return user.when(data: (userInfo) {
      return RichTwoPartsText(
        leftPart: userInfo.displayName!,
        rightPart: comment.comment,
      );
    }, error: (error, stacktrace) {
      return const SmallErrorAnimationView();
    }, loading: () {
      return const CircularProgressIndicator();
    });
  }
}
