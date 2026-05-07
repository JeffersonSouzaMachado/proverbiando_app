import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proverbiando/core/firebase/providers/firebase_providers.dart';
import 'package:proverbiando/core/firebase/domain/entities/proverb_entity.dart';
import 'package:proverbiando/core/firebase/providers/proverb_providers.dart';

final proverbNotifierProvider =
    AsyncNotifierProvider<ProverbNotifier, ProverbEntity>(ProverbNotifier.new);

class ProverbNotifier extends AsyncNotifier<ProverbEntity> {
  @override
  FutureOr<ProverbEntity> build() {
    final useCase = ref.watch(getRandomProverbUseCaseProvider);

    return useCase();
  }

  Future<void> refreshProverb() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final useCase = ref.read(getRandomProverbUseCaseProvider);
      return useCase();
    });
  }

  Future<bool> saveCurrentProverb({required ProverbEntity proverb}) async {
    final user = await ref.read(currentUserProvider.future);
    final userId = user.id;

    final saveCaseUse = ref.read(saveProverbUseCaseProvider);

    final updatedProverb = ProverbEntity(
      text: proverb.text,
      reference: proverb.reference,
      version: proverb.version,
      addedAt: DateTime.now().toString(),
    );

    final wasSaved = await saveCaseUse(proverb: updatedProverb, userId: userId);

    return wasSaved;
  }
}
