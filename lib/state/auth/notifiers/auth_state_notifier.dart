import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgramclonexyz/state/auth/backend/authenticator.dart';
import 'package:instantgramclonexyz/state/auth/models/auth_result.dart';
import 'package:instantgramclonexyz/state/auth/models/auth_state.dart';
import 'package:instantgramclonexyz/state/posts/typedefs/user_id.dart';
import 'package:instantgramclonexyz/state/user_info/backend/user_info_storage.dart'; // Add this line to import the Authenticator class

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = const Authenticator();
  final _userInfoStorage = const UserInfoStorage();

  AuthStateNotifier() : super(const AuthState.unknkonwn()) {
    if (_authenticator.isAlreadyLoggedIn) {
      state = AuthState(
        result: AuthResult.success,
        isLoading: false,
        userId: _authenticator.userId,
      );
    }
  }

  Future<void> loginWithGoogle() async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.loginWithGoogle();
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(userId, null);
    }
    state = AuthState(result: result, isLoading: false, userId: userId);
  }

  Future<void> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    state = state.copiedWithIsLoading(true);
    final result =
        await _authenticator.loginWithEmailAndPassword(email, password);
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(userId, null);
    }
    state = AuthState(result: result, isLoading: false, userId: userId);
  }

  Future<void> signUpWithEmailAndPassword(
      {required String name,
      required String email,
      required String password}) async {
    state = state.copiedWithIsLoading(true);
    final result =
        await _authenticator.signUpWithEmailAndPassword(email, password, name);
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(userId, name);
    }
    state = AuthState(result: result, isLoading: false, userId: userId);
  }

  Future<void> logOut() async {
    state = state.copiedWithIsLoading(true);
    await _authenticator.logOut();
    state = const AuthState.unknkonwn();
  }

  Future<void> saveUserInfo(UserId userId, String? displayname) =>
      _userInfoStorage.saveUserInfo(
        userId: userId,
        displayName: displayname ?? _authenticator.displayName,
        email: _authenticator.email,
      );
}
