import 'package:proverbiando/core/firebase/domain/repositories/proverb_repository.dart';

class DeleteSelectedProverbUseCase {
  final ProverbRepository repository;

  DeleteSelectedProverbUseCase({required this.repository});

  Future<void> call({required String userId, required String proverbId}) async {
    return repository.deleteSelectedProverb(
      userId: userId,
      proverbId: proverbId,
    );
  }
}
