import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgramclonexyz/state/auth/notifiers/create_account_notifier.dart';

final createAccountProvider =
    StateNotifierProvider<CreateAccountNotifier, bool>((ref) {
  return CreateAccountNotifier();
});
