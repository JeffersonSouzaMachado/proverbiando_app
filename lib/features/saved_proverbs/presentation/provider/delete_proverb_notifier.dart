import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proverbiando/core/firebase/providers/firebase_providers.dart';
import 'package:proverbiando/core/firebase/providers/proverb_providers.dart';
import 'package:proverbiando/features/saved_proverbs/presentation/provider/saved_proverb_notifer.dart';

final deleteProverbProvider =
    AsyncNotifierProvider<DeleteProverbNotifier, void>(
      DeleteProverbNotifier.new,
    );

class DeleteProverbNotifier extends AsyncNotifier {
  @override
  FutureOr<dynamic> build() {}

  FutureOr<void> deleteProverb({required String proverbId}) async {
    final user = await ref.read(currentUserProvider.future);
    final useCase = ref.watch(deleteSelectedProverbProvider);

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await useCase(userId: user.id, proverbId: proverbId);
      ref.invalidate(savedProverbProvider);
    });
  }
}
