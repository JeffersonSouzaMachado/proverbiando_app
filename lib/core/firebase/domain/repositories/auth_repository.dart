
abstract class AuthRepository {
  Future<String> signInAnonymously();

  Future<String?> getCurrentUserId();
}

