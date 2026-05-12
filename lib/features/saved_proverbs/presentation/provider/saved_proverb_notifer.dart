import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proverbiando/core/analytics/analytics_events.dart';
import 'package:proverbiando/core/analytics/analytics_provider.dart';
import 'package:proverbiando/core/firebase/domain/entities/proverb_entity.dart';
import 'package:proverbiando/core/firebase/providers/firebase_providers.dart';
import 'package:proverbiando/core/firebase/providers/proverb_providers.dart';

final savedProverbProvider =
    AsyncNotifierProvider<SavedProverbNotifier, List<ProverbEntity>>(
      SavedProverbNotifier.new,
    );

class SavedProverbNotifier extends AsyncNotifier<List<ProverbEntity>> {
  @override
  FutureOr<List<ProverbEntity>> build() async {
    final user = await ref.read(currentUserProvider.future);
    final useCase = ref.watch(getSavedProverbsUseCaseProvider);
    final proverbs = await useCase(userId: user.id);

    await ref
        .read(analyticsServiceProvider)
        .logEvent(
          AnalyticsEvents.savedProverbsLoaded,
          parameters: {'saved_count': proverbs.length},
        );

    return proverbs;
  }

  Future<void> refreshSavedProverbs() async {
    final user = await ref.read(currentUserProvider.future);

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final useCase = ref.read(getSavedProverbsUseCaseProvider);
      final proverbs = await useCase(userId: user.id);

      await ref
          .read(analyticsServiceProvider)
          .logEvent(
            AnalyticsEvents.savedProverbsRefreshed,
            parameters: {'saved_count': proverbs.length},
          );

      return proverbs;
    });
  }
}
