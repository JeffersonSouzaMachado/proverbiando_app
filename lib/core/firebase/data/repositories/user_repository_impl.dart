import 'package:proverbiando/core/firebase/data/datasources/user_datasource.dart';
import 'package:proverbiando/core/firebase/domain/entities/user_entity.dart';
import 'package:proverbiando/core/firebase/domain/repositories/user_repository.dart';
import 'package:proverbiando/core/firebase/data/models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDatasource datasource;

  UserRepositoryImpl(this.datasource);

  @override
  Future<void> createUser(UserEntity user) async {
    final userModel = UserModel.fromEntity(user);
    await datasource.createUser(userModel);
  }

  @override
  Future<UserEntity?> getUserById(String userId) async {
    final model = await datasource.getUserById(userId);
    return model?.toEntity();
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    final userModel = UserModel.fromEntity(user);
    await datasource.updateUser(userModel);
  }
}
