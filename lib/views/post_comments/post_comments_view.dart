import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgramclonexyz/state/auth/providers/user_id_provider.dart';
import 'package:instantgramclonexyz/state/comments/models/post_comments_request.dart';
import 'package:instantgramclonexyz/state/comments/provider/post_comments_provider.dart';
import 'package:instantgramclonexyz/state/comments/provider/send_comment_provider.dart';
import 'package:instantgramclonexyz/state/posts/typedefs/post_id.dart';
import 'package:instantgramclonexyz/views/components/animations/empty_contents_with_text_animation_view.dart';
import 'package:instantgramclonexyz/views/components/animations/error_animation.dart';
import 'package:instantgramclonexyz/views/components/animations/loading_animation.dart';
import 'package:instantgramclonexyz/views/components/comments/comment_tile.dart';
import 'package:instantgramclonexyz/views/constants/strings.dart';
import 'package:instantgramclonexyz/views/extensions/dismiss_keyboard.dart';

class PostCommentsView extends HookConsumerWidget {
  final PostId postId;

  const PostCommentsView({
    super.key,
    required this.postId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentController = useTextEditingController();

    final hasText = useState(false);

    final request = useState(RequestForPostAndComments(postId: postId));

    final comments = ref.watch(postCommentsProvider(request.value));

    useEffect(() {
      commentController.addListener(
        () {
          hasText.value = commentController.text.isNotEmpty;
        },
      );
      return () {};
    }, [commentController]);

    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.comments),
        actions: [
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: hasText.value
                ? () {
                    _submitCommentWithController(
                      commentController,
                      ref,
                    );
                  }
                : null,
          )
        ],
      ),
      body: SafeArea(
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 4,
              child: comments.when(
                data: (comments) {
                  if (comments.isEmpty) {
                    return const SingleChildScrollView(
                      child: EmptyContentsWithTextAnimationView(
                        text: Strings.noCommentsYet,
                      ),
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: () async {
                      ref.refresh(postCommentsProvider(request.value));
                      return Future.delayed(const Duration(seconds: 1));
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        final comment = comments.elementAt(index);
                        return CommentTile(comment: comment);
                      },
                    ),
                  );
                },
                error: (error, stackTrace) {
                  return const ErrorAnimationView();
                },
                loading: () {
                  return const LoadingAnimationView();
                },
              ),
            ),
            Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                      right: 8,
                    ),
                    child: TextField(
                      textInputAction: TextInputAction.send,
                      controller: commentController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: Strings.writeYourCommentHere,
                      ),
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          _submitCommentWithController(
                            commentController,
                            ref,
                          );
                        }
                      },
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Future<void> _submitCommentWithController(
    TextEditingController controller,
    WidgetRef ref,
  ) async {
    final userId = ref.read(userIdProviderProvider);
    if (userId == null) {
      return;
    }
    final isSent = await ref.read(sendCommentProvider.notifier).sendComment(
          fromUserId: userId,
          onPostId: postId,
          comment: controller.text,
        );

    if (isSent) {
      controller.clear();
      dismissKeyboard();
    }
  }
}
