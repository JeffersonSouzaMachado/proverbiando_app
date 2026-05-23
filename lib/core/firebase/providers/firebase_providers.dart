import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proverbiando/core/firebase/data/datasources/auth_datasource.dart';
import 'package:proverbiando/core/firebase/data/datasources/user_device_datasource.dart';
import 'package:proverbiando/core/firebase/data/datasources/user_datasource.dart';
import 'package:proverbiando/core/firebase/data/repositories/auth_repository_impl.dart';
import 'package:proverbiando/core/firebase/data/repositories/user_device_repository_impl.dart';
import 'package:proverbiando/core/firebase/data/repositories/user_repository_impl.dart';
import 'package:proverbiando/core/firebase/domain/entities/user_entity.dart';
import 'package:proverbiando/core/firebase/domain/repositories/auth_repository.dart';
import 'package:proverbiando/core/firebase/domain/repositories/user_device_repository.dart';
import 'package:proverbiando/core/firebase/domain/repositories/user_repository.dart';
import 'package:proverbiando/core/firebase/usecases/get_or_create_user_usecase.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final authDataSourceProvider = Provider<AuthDatasource>((ref) {
  return AuthDatasourceImpl(ref.read(firebaseAuthProvider));
});

final userDataSourceProvider = Provider<UserDatasource>((ref) {
  return UserDatasourceImpl(ref.read(firestoreProvider));
});

final userDeviceDataSourceProvider = Provider<UserDeviceDatasource>((ref) {
  return UserDeviceDatasourceImpl(ref.read(firestoreProvider));
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref.read(authDataSourceProvider));
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepositoryImpl(ref.read(userDataSourceProvider));
});

final userDeviceRepositoryProvider = Provider<UserDeviceRepository>((ref) {
  return UserDeviceRepositoryImpl(ref.read(userDeviceDataSourceProvider));
});

final getOrCreateUserUseCaseProvider = Provider<GetOrCreateUserUseCase>((ref) {
  return GetOrCreateUserUseCase(
    authRepository: ref.read(authRepositoryProvider),
    userRepository: ref.read(userRepositoryProvider),
  );
});

final currentUserProvider = FutureProvider<UserEntity>((ref) {
  final useCase = ref.read(getOrCreateUserUseCaseProvider);
  return useCase();
});
