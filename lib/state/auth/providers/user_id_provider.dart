import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgramclonexyz/state/auth/models/auth_result.dart';
import 'package:instantgramclonexyz/state/auth/providers/auth_state_provider.dart';
import 'package:instantgramclonexyz/state/posts/typedefs/user_id.dart';

final isLoggedInProvider = Provider<UserId?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.userId;
});
