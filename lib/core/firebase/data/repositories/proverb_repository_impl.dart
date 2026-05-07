import 'package:proverbiando/features/home/data/datasources/proverb_datasource.dart';
import 'package:proverbiando/core/firebase/data/datasources/proverb_firebase_datasource.dart';
import 'package:proverbiando/core/firebase/data/models/proverb_model_from_firebase.dart';
import 'package:proverbiando/core/firebase/domain/entities/proverb_entity.dart';
import 'package:proverbiando/core/firebase/domain/repositories/proverb_repository.dart';

class ProverbRepositoryImpl implements ProverbRepository {
  final ProverbRemoteDatasource remoteDatasource;
  final ProverbFirebaseDatasource firebaseDatasource;

  ProverbRepositoryImpl(this.remoteDatasource, this.firebaseDatasource);

  @override
  Future<ProverbEntity> getRandomProverb() async {
    final model = await remoteDatasource.getRandomProverb();
    return model.toEntity();
  }

  @override
  Future<bool> saveProverb({
    required String userId,
    required ProverbEntity proverb,
  }) async {
    final alreadySaved = await firebaseDatasource.checkProverbExist(
      userId: userId,
      reference: proverb.reference,
    );

    if (alreadySaved) {
      return false;
    }

    final model = ProverbModelFromFirebase.fromEntity(proverb);

    await firebaseDatasource.saveProverb(userId: userId, proverb: model);

    return true;
  }

  @override
  Future<List<ProverbEntity>> getSavedProverbs({required String userId}) async {
    final data = await firebaseDatasource.getSavedProverbs(userId: userId);

    final proverbList = data.map((doc) => doc.toEntity()).toList();

    return proverbList;
  }


}
