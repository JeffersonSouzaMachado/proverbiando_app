import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthDatasource {
  Future<String> signInAnonymously();

  Future<String?> getCurrentUserId();
}

class AuthDatasourceImpl implements AuthDatasource {
  final FirebaseAuth firebaseAuth;

  AuthDatasourceImpl(this.firebaseAuth);

  @override
  Future<String?> getCurrentUserId() async {
    return firebaseAuth.currentUser?.uid;
  }

  @override
  Future<String> signInAnonymously() async {
    final credential = await firebaseAuth.signInAnonymously();
    return credential.user!.uid;
  }
}
