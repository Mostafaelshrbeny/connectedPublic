import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleAuth {
  static signIn() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      // Now you can send the credential to your backend to validate and create a session
      print(credential);
    } catch (error) {
      print(error);
    }
  }
}
