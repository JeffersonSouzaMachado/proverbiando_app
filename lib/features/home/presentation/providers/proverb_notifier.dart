import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proverbiando/core/analytics/analytics_events.dart';
import 'package:proverbiando/core/analytics/analytics_provider.dart';
import 'package:proverbiando/core/firebase/providers/firebase_providers.dart';
import 'package:proverbiando/core/firebase/domain/entities/proverb_entity.dart';
import 'package:proverbiando/core/firebase/providers/proverb_providers.dart';

final proverbNotifierProvider =
    AsyncNotifierProvider<ProverbNotifier, ProverbEntity>(ProverbNotifier.new);

class ProverbNotifier extends AsyncNotifier<ProverbEntity> {
  @override
  FutureOr<ProverbEntity> build() async {
    final useCase = ref.watch(getRandomProverbUseCaseProvider);
    final proverb = await useCase();

    await ref
        .read(analyticsServiceProvider)
        .logEvent(
          AnalyticsEvents.proverbLoaded,
          parameters: {
            'reference': proverb.reference,
            'version': proverb.version,
          },
        );

    return proverb;
  }

  Future<void> refreshProverb() async {
    state = const AsyncLoading<ProverbEntity>().copyWithPrevious(state);

    state = await AsyncValue.guard(() async {
      final useCase = ref.read(getRandomProverbUseCaseProvider);
      final proverb = await useCase();

      await ref
          .read(analyticsServiceProvider)
          .logEvent(
            AnalyticsEvents.proverbRefreshed,
            parameters: {
              'reference': proverb.reference,
              'version': proverb.version,
            },
          );

      return proverb;
    });
  }

  Future<bool> saveCurrentProverb({required ProverbEntity proverb}) async {
    final previousState = state;
    final user = await ref.read(currentUserProvider.future);
    final userId = user.id;
    bool wasSaved = false;
    state = const AsyncLoading<ProverbEntity>().copyWithPrevious(previousState);

    try {
      final saveCaseUse = ref.read(saveProverbUseCaseProvider);

      final updatedProverb = ProverbEntity(
        text: proverb.text,
        reference: proverb.reference,
        version: proverb.version,
        addedAt: DateTime.now().toString(),
      );

      wasSaved = await saveCaseUse(proverb: updatedProverb, userId: userId);

      final eventName = wasSaved
          ? AnalyticsEvents.proverbSaved
          : AnalyticsEvents.proverbSaveDuplicate;

      await ref
          .read(analyticsServiceProvider)
          .logEvent(
            eventName,
            parameters: {
              'reference': proverb.reference,
              'version': proverb.version,
            },
          );
      state = AsyncData(proverb);
    } catch (e, s) {
      state = AsyncError(e, s);
    }

    return wasSaved;
  }
}
