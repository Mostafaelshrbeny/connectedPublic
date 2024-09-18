import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookAuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<User?> signInWithFacebook() async {
    try {
      // Trigger the Facebook Sign-In flow
      final LoginResult result = await FacebookAuth.instance.login();

      switch (result.status) {
        case LoginStatus.success:
          // Obtain the auth details from the request
          final AccessToken accessToken = result.accessToken!;

          // Create a credential from the access token
          final OAuthCredential credential =
              FacebookAuthProvider.credential(accessToken.tokenString);

          // Once signed in, return the UserCredential
          UserCredential userCredential =
              await _auth.signInWithCredential(credential);
          print(userCredential.user);
          return userCredential.user;

        case LoginStatus.cancelled:
          print('Login cancelled by the user.');
          return null;

        case LoginStatus.failed:
          print('Login failed: ${result.message}');
          return null;

        default:
          return null;
      }
    } catch (e) {
      print('Error during Facebook sign-in: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await FacebookAuth.instance.logOut();
  }
}
