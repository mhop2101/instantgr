import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgramclonexyz/state/auth/providers/user_id_provider.dart';
import 'package:instantgramclonexyz/state/posts/models/post.dart';

final canCurrentUserDeletePostProvider =
    StreamProvider.family.autoDispose<bool, Post>((ref, post) async* {
  final userId = ref.watch(userIdProviderProvider);
  yield userId == post.userId;
});
