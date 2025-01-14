import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgramclonexyz/state/posts/models/post.dart';
import 'package:instantgramclonexyz/state/user_info/providers/user_info_model_provider.dart';
import 'package:instantgramclonexyz/views/components/animations/small_error_animation.dart';
import 'package:instantgramclonexyz/views/components/rich_two_parts_text.dart';

class PostDisplayNameAndMessageView extends ConsumerWidget {
  final Post post;
  const PostDisplayNameAndMessageView({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfoModel = ref.watch(userInfoModelProvider(post.userId));
    return userInfoModel.when(data: (userInfoModel) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: RichTwoPartsText(
          leftPart: userInfoModel.displayName!,
          rightPart: post.message,
        ),
      );
    }, error: (error, stack) {
      return const SmallErrorAnimationView();
    }, loading: () {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
