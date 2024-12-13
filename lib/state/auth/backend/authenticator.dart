import 'package:firebase_auth/firebase_auth.dart';
import 'package:instantgramclonexyz/state/auth/constants/constants.dart';
import 'package:instantgramclonexyz/state/auth/models/auth_result.dart';
import 'package:instantgramclonexyz/state/posts/typedefs/user_id.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authenticator {
  const Authenticator();
  User? get currentUser => FirebaseAuth.instance.currentUser;
  UserId? get userId => currentUser?.uid;
  bool get isAlreadyLoggedIn => userId != null;
  String get displayName => currentUser?.displayName ?? '';
  String get email => currentUser?.email ?? '';

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  Future<AuthResult> loginWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
      Constants.emailScope,
    ]);
    final signInAccount = await googleSignIn.signIn();
    if (signInAccount == null) {
      return AuthResult.aborted;
    }
    final googleauth = await signInAccount.authentication;
    final oauthCredentials = GoogleAuthProvider.credential(
      accessToken: googleauth.accessToken,
      idToken: googleauth.idToken,
    );
    try {
      await FirebaseAuth.instance.signInWithCredential(oauthCredentials);
      return AuthResult.success;
    } catch (e) {
      return AuthResult.failure;
    }
  }

  Future<AuthResult> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AuthResult.success;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return AuthResult.userNotFound;
      } else if (e.code == 'wrong-password') {
        return AuthResult.wrongPassword;
      }
      return AuthResult.failure;
    }
  }

  Future<AuthResult> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user!.updateDisplayName(name);
      return AuthResult.success;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return AuthResult.weakPassword;
      } else if (e.code == 'email-already-in-use') {
        return AuthResult.emailAlreadyInUse;
      }
      return AuthResult.failure;
    }
  }
}
