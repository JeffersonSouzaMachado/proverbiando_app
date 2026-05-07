import 'package:proverbiando/core/firebase/domain/entities/proverb_entity.dart';
import 'package:proverbiando/core/firebase/domain/repositories/proverb_repository.dart';

class SaveProverbUseCase {
  final ProverbRepository repository;

  SaveProverbUseCase(this.repository);

  Future<bool> call({
    required String userId,
    required ProverbEntity proverb,
  }) async {
    return repository.saveProverb(userId: userId, proverb: proverb);
  }
}
