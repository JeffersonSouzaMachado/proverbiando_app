import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proverbiando/core/firebase/data/models/user_model.dart';

abstract class UserDatasource {
  Future<void> createUser(UserModel user);

  Future<UserModel?> getUserById(String userId);

  Future<void> updateUser(UserModel user);
}

class UserDatasourceImpl implements UserDatasource {
  UserDatasourceImpl(this.firestore);

  final FirebaseFirestore firestore;
  late final userCollection = firestore.collection('users');

  @override
  Future<void> createUser(UserModel user) async {
    await userCollection.doc(user.id).set(user.toJson());
  }

  @override
  Future<UserModel?> getUserById(String userId) async {
    final doc = await userCollection.doc(userId).get();

    if (!doc.exists || doc.data() == null) {
      return null;
    }

    return UserModel.fromJson(doc.data()!);
  }

  @override
  Future<void> updateUser(UserModel user) async {
    await userCollection
        .doc(user.id)
        .set(user.toJson(), SetOptions(merge: true));
  }
}
