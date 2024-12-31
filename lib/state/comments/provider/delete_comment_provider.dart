import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgramclonexyz/state/comments/notifiers/delete_comment_notifier.dart';
import 'package:instantgramclonexyz/state/image_upload/typedefs/is_loading.dart';

final deleteCommentProvider =
    StateNotifierProvider<DeleteCommentStateNotifier, IsLoading>((ref) {
  return DeleteCommentStateNotifier();
});
