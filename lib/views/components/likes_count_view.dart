import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgramclonexyz/state/likes/providers/post_likes_count_provider.dart';
import 'package:instantgramclonexyz/state/posts/typedefs/post_id.dart';
import 'package:instantgramclonexyz/views/components/animations/small_error_animation.dart';
import 'package:instantgramclonexyz/views/components/constants/strings.dart';

class LikesCountView extends ConsumerWidget {
  final PostId postId;

  const LikesCountView({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likesCount = ref.watch(postLikesCountProvider(postId));
    return likesCount.when(
      data: (likes) {
        final personOrPeople = likes == 1 ? Strings.person : Strings.people;
        final likesText = '$likes $personOrPeople ${Strings.likedThis}';
        return Text(likesText);
      },
      error: (error, stackTrace) => const SmallErrorAnimationView(),
      loading: () {
        return const CircularProgressIndicator();
      },
    );
  }
}
