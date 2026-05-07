import 'package:proverbiando/core/firebase/data/datasources/auth_datasource.dart';
import 'package:proverbiando/core/firebase/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource authDatasource;

  AuthRepositoryImpl(this.authDatasource);

  @override
  Future<String> signInAnonymously() {
    return authDatasource.signInAnonymously();
  }

  @override
  Future<String?> getCurrentUserId() {
    return authDatasource.getCurrentUserId();
  }
}
