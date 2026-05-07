import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proverbiando/core/firebase/data/models/proverb_model_from_firebase.dart';

abstract class ProverbFirebaseDatasource {
  Future<void> saveProverb({
    required String userId,
    required ProverbModelFromFirebase proverb,
  });

  Future<bool> checkProverbExist({
    required String userId,
    required String reference,
  });

  Future<List<ProverbModelFromFirebase>> getSavedProverbs({
    required String userId,
  });
}

class ProverbFirebaseDatasourceImpl implements ProverbFirebaseDatasource {
  ProverbFirebaseDatasourceImpl(this.firestore);

  final FirebaseFirestore firestore;
  late final userCollection = firestore.collection('users');

  @override
  Future<void> saveProverb({
    required String userId,
    required ProverbModelFromFirebase proverb,
  }) async {
    await userCollection
        .doc(userId)
        .collection('savedProverbs')
        .add(proverb.toJson());
  }

  @override
  Future<bool> checkProverbExist({
    required String userId,
    required String reference,
  }) async {
    final query = await userCollection
        .doc(userId)
        .collection('savedProverbs')
        .where('reference', isEqualTo: reference)
        .limit(1)
        .get();

    return query.docs.isNotEmpty;
  }

  @override
  Future<List<ProverbModelFromFirebase>> getSavedProverbs({
    required String userId,
  }) async {
    final data = await userCollection
        .doc(userId)
        .collection('savedProverbs')
        .get();

    final proverbs = data.docs.map((doc) {
      return ProverbModelFromFirebase.fromJson(doc.data());
    }).toList();

    return proverbs;
  }
}
