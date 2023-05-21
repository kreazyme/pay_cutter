import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:pay_cutter/data/models/dto/user.dto.dart';

@lazySingleton
class FirebaseAuthDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Future<bool> checkLogin() async {
    final user = _auth.currentUser;
    return user != null;
  }

  Future<UserDTO?> loginGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _auth.signInWithCredential(credential);
      User? user = _auth.currentUser;
      return UserDTO(
        name: user?.displayName ?? '',
        email: user?.email ?? '',
        photoUrl: user?.photoURL ?? '',
        googleToken: googleAuth.accessToken ?? '',
      );
    } catch (error) {
      return null;
    }
  }

  Future<String> loginFacebook() async {
    try {
      final facebookUser = await _auth.signInWithPopup(FacebookAuthProvider());
      final credential = facebookUser.credential;
      if (credential != null) {
        return credential.accessToken.toString();
      }
      return '';
    } catch (e) {
      return '';
    }
  }

  Future<void> signout() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
