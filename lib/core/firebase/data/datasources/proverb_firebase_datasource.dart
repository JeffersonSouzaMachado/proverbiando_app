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

  Future<void> deleteSelectedProverb({
    required String userId,
    required String proverbId,
  });
}

class ProverbFirebaseDatasourceImpl implements ProverbFirebaseDatasource {
  ProverbFirebaseDatasourceImpl(this.firestore);

  final FirebaseFirestore firestore;
  late final userCollection = firestore.collection('users');
  final proverbCollection = 'savedProverbs';

  @override
  Future<void> saveProverb({
    required String userId,
    required ProverbModelFromFirebase proverb,
  }) async {
    await userCollection
        .doc(userId)
        .collection(proverbCollection)
        .add(proverb.toJson());
  }

  @override
  Future<bool> checkProverbExist({
    required String userId,
    required String reference,
  }) async {
    final query = await userCollection
        .doc(userId)
        .collection(proverbCollection)
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
        .collection(proverbCollection)
        .get();

    final proverbs = data.docs.map((doc) {
      return ProverbModelFromFirebase.fromJson({...doc.data(), 'id': doc.id});
    }).toList();

    return proverbs;
  }

  @override
  Future<void> deleteSelectedProverb({
    required String userId,
    required String proverbId,
  }) async {
    try {
      await userCollection
          .doc(userId)
          .collection(proverbCollection)
          .doc(proverbId)
          .delete();
    } catch (e) {
      throw Exception(e);
    }
  }
}
