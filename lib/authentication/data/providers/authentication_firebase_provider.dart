import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationFirebaseProvider {
  final FirebaseAuth firebaseAuth;
  AuthenticationFirebaseProvider({
    required this.firebaseAuth,
  });

  Stream<User?> getAuthStateChanges() {
    return firebaseAuth.authStateChanges();
  }

  Future<void> authenticatedUser() async {
    await firebaseAuth.signInAnonymously();
  }

  Future<void> unauthenticatedUser() async {
    await firebaseAuth.signOut();
  }
}
