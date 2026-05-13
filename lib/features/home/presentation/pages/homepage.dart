import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proverbiando/features/home/presentation/providers/proverb_notifier.dart';
import 'package:proverbiando/features/home/presentation/widgets/main_card.dart';
import 'package:proverbiando/features/saved_proverbs/presentation/provider/saved_proverb_notifer.dart';

class Homepage extends ConsumerWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(proverbNotifierProvider);

    return state.when(
      skipLoadingOnRefresh: true,
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
      data: (data) {
        return MainCard(
          proverb: data,
          refreshProverb: () {
            ref.read(proverbNotifierProvider.notifier).refreshProverb();
          },
          saveProverb: () async {
            final wasSaved = await ref
                .read(proverbNotifierProvider.notifier)
                .saveCurrentProverb(proverb: data);

            if (!context.mounted) return;

            if (wasSaved == true) {
              ref.invalidate(savedProverbProvider);
            }

            Fluttertoast.showToast(
              msg: wasSaved
                  ? 'Provérbio salvo com sucesso!'
                  : 'Esse provérbio já está salvo.',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
            );
          },
        );
      },
    );
  }
}
