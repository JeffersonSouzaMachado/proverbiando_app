import 'package:proverbiando/core/firebase/domain/entities/proverb_entity.dart';

abstract class ProverbRepository {
  Future<ProverbEntity> getRandomProverb();

  Future<bool> saveProverb({
    required String userId,
    required ProverbEntity proverb,
  });

  Future<List<ProverbEntity>> getSavedProverbs({required String userId});
}
