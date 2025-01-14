import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgramclonexyz/state/auth/providers/user_id_provider.dart';
import 'package:instantgramclonexyz/state/likes/models/like_dislike_request.dart';
import 'package:instantgramclonexyz/state/likes/providers/has_liked_post_provier.dart';
import 'package:instantgramclonexyz/state/likes/providers/like_dislike_post_provider.dart';
import 'package:instantgramclonexyz/state/posts/typedefs/post_id.dart';
import 'package:instantgramclonexyz/views/components/animations/small_error_animation.dart';

class LikeButton extends ConsumerWidget {
  final PostId postId;
  LikeButton({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasLiked = ref.watch(hasLikedPostProvider(postId));
    return hasLiked.when(data: (hasLiked) {
      return IconButton(
        icon: FaIcon(
          hasLiked ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
        ),
        onPressed: () {
          final likedBy = ref.read(userIdProviderProvider);
          if (likedBy == null) {
            return;
          }
          final likeDislikeRequest = LikeDislikeRequest(
            postId: postId,
            likedBy: likedBy,
          );
          ref.read(
            likeDislikePostProvider(
              likeDislikeRequest,
            ),
          );
        },
      );
    }, error: (error, stack) {
      return const SmallErrorAnimationView();
    }, loading: () {
      return const Center(child: CircularProgressIndicator());
    });
  }
}
