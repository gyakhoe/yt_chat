import 'package:yt_chat/authentication/data/providers/authentication_firebase_provider.dart';

class AuthenticationRepository {
  final AuthenticationFirebaseProvider authenticationFirebaseProvider;

  AuthenticationRepository({
    required this.authenticationFirebaseProvider,
  });

  Stream<String> getAuthenticationChanges() {
    return authenticationFirebaseProvider
        .getAuthStateChanges()
        .map((firebaseUser) => firebaseUser?.uid ?? '');
  }

  Future<void> authenticatedUser() async {
    return authenticationFirebaseProvider.authenticatedUser();
  }

  Future<void> unauthenticateUser() async {
    return authenticationFirebaseProvider.unauthenticatedUser();
  }
}
