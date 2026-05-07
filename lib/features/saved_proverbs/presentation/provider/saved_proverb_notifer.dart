import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proverbiando/core/firebase/domain/entities/proverb_entity.dart';
import 'package:proverbiando/core/firebase/providers/firebase_providers.dart';
import 'package:proverbiando/core/firebase/providers/proverb_providers.dart';

final savedProverbProvider =
    AsyncNotifierProvider<SavedProverbNotifier, List<ProverbEntity>>(
      SavedProverbNotifier.new,
    );

class SavedProverbNotifier extends AsyncNotifier<List<ProverbEntity>> {
  @override
  FutureOr<List<ProverbEntity>> build() async{
    final user = await ref.read(currentUserProvider.future);
    final useCase = ref.watch(getSavedProverbsUseCaseProvider);

    return useCase(userId: user.id);
  }

  Future<void> refreshSavedProverbs() async {
    final user = await ref.read(currentUserProvider.future);

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final useCase = ref.read(getSavedProverbsUseCaseProvider);
      return useCase(userId: user.id);
    });
  }
}
