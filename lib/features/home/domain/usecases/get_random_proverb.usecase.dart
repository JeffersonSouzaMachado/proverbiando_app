

import 'package:proverbiando/core/firebase/domain/entities/proverb_entity.dart';
import 'package:proverbiando/core/firebase/domain/repositories/proverb_repository.dart';

class GetRandomProverbUseCase {
  final ProverbRepository repository;

  GetRandomProverbUseCase(this.repository);

  Future<ProverbEntity> call(){
    return repository.getRandomProverb();
  }

}