import 'package:evira_e_commerce/core/constants/redirects.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton()
class SocialAuthService {
  Future<void> signInWithFacebook() async {
    await Supabase.instance.client.auth.signInWithOAuth(
      OAuthProvider.facebook,
      redirectTo: Redirects.facebook,
    );
  }

  bool isLoggedIn() {
    final session = Supabase.instance.client.auth.currentSession;
    return session != null; // true if logged in, false if logged out
  }

  Future<void> signOut() async {
    await Supabase.instance.client.auth.signOut();
  }

  Future<void> signInWithGoogle() async {
    final scopes = ['email', 'profile'];
    final googleSignIn = GoogleSignIn.instance;
    await googleSignIn.initialize(
      serverClientId: dotenv.env['WEB_CLIENT_ID'],
      clientId: dotenv.env['IOS_CLIENT_ID'],
    );
    final googleUser = await googleSignIn.authenticate();
    // or await googleSignIn.authenticate(); which will return a GoogleSignInAccount or throw an exception
    // if (googleUser.email) {
    //   throw AuthException('Failed to sign in with Google.');
    // }

    /// Authorization is required to obtain the access token with the appropriate scopes for Supabase authentication,
    /// while also granting permission to access user information.
    final authorization =
        await googleUser.authorizationClient.authorizationForScopes(scopes) ??
        await googleUser.authorizationClient.authorizeScopes(scopes);
    final idToken = googleUser.authentication.idToken;
    if (idToken == null) {
      throw AuthException('No ID Token found.');
    }
    await Supabase.instance.client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: authorization.accessToken,
    );
  }
}
