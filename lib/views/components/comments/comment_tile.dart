import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgramclonexyz/state/auth/providers/user_id_provider.dart';
import 'package:instantgramclonexyz/state/comments/models/comment.dart';
import 'package:instantgramclonexyz/state/comments/provider/delete_comment_provider.dart';
import 'package:instantgramclonexyz/state/user_info/providers/user_info_model_provider.dart';
import 'package:instantgramclonexyz/views/components/animations/small_error_animation.dart';
import 'package:instantgramclonexyz/views/components/constants/strings.dart';
import 'package:instantgramclonexyz/views/components/dialogs/alert_dialog_model.dart';
import 'package:instantgramclonexyz/views/components/dialogs/delete_dialog.dart';

class CommentTile extends ConsumerWidget {
  final Comment comment;
  const CommentTile({required this.comment, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userInfoModelProvider(comment.fromUserId));
    return userInfo.when(data: (userInfoModel) {
      final currentUserId = ref.read(userIdProviderProvider);
      return ListTile(
        title: Text(userInfoModel.displayName!),
        subtitle: Text(comment.comment),
        trailing: currentUserId == comment.fromUserId
            ? IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  final shouldDelete = await displayDeleteDialog(context);
                  if (shouldDelete) {
                    await ref
                        .read(deleteCommentProvider.notifier)
                        .deleteComment(commentId: comment.id);
                  }
                },
              )
            : null,
      );
    }, error: (error, stackTrace) {
      return const SmallErrorAnimationView();
    }, loading: () {
      return const CircularProgressIndicator();
    });
  }

  Future<bool> displayDeleteDialog(BuildContext context) =>
      DeleteDialog(titleOfObjectToDelete: Strings.comment)
          .present(context)
          .then((value) => value ?? false);
}
