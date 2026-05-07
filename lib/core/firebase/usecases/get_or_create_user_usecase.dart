import 'package:proverbiando/core/firebase/domain/entities/user_entity.dart';
import 'package:proverbiando/core/firebase/domain/repositories/auth_repository.dart';
import 'package:proverbiando/core/firebase/domain/repositories/user_repository.dart';

class GetOrCreateUserUseCase {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  GetOrCreateUserUseCase({
    required this.authRepository,
    required this.userRepository,
  });

  Future<UserEntity> call() async {
    String? currentUserId = await authRepository.getCurrentUserId();

    currentUserId ??= await authRepository.signInAnonymously();

    final user = await userRepository.getUserById(currentUserId);

    if (user != null) {
      return user;
    }

    final newUser = UserEntity(id: currentUserId,
        createdAt: DateTime.timestamp().toString(),
        isAnonymous: true,
        lastSeen: DateTime.now().toString());

    await userRepository.createUser(newUser);

    return newUser;
  }
}
