import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgramclonexyz/state/auth/providers/auth_state_provider.dart';
import 'package:instantgramclonexyz/state/comments/provider/delete_comment_provider.dart';
import 'package:instantgramclonexyz/state/comments/provider/send_comment_provider.dart';
import 'package:instantgramclonexyz/state/image_upload/providers/image_or_video_pick_provider.dart';
import 'package:instantgramclonexyz/state/image_upload/providers/image_uploader_provider.dart';
import 'package:instantgramclonexyz/state/posts/providers/delete_post_provider.dart';

final isLoadingProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  final isUploadImageLoading = ref.watch(imageUploadProvider);
  final isSendingComment = ref.watch(sendCommentProvider);
  final isDeletingComment = ref.watch(deleteCommentProvider);
  final isDeletingPost = ref.watch(deletePostProvider);
  final isPickImageOrVideoLoading = ref.watch(imageOrVideoPickLoadingProvider);
  return authState.isLoading ||
      isUploadImageLoading ||
      isSendingComment ||
      isDeletingComment ||
      isDeletingPost ||
      isPickImageOrVideoLoading;
});
