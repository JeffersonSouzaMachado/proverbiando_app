import 'package:proverbiando/core/firebase/domain/entities/proverb_entity.dart';
import 'package:proverbiando/core/firebase/domain/repositories/proverb_repository.dart';

class GetSavedProverbsUseCase {
  final ProverbRepository repository;

  GetSavedProverbsUseCase(this.repository);

  Future<List<ProverbEntity>> call({required String userId}) {
    return repository.getSavedProverbs(userId: userId);
  }
}