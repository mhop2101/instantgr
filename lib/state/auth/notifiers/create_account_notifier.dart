import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateAccountNotifier extends StateNotifier<bool> {
  CreateAccountNotifier() : super(false);
  void toggle() {
    state = !state;
  }
}
