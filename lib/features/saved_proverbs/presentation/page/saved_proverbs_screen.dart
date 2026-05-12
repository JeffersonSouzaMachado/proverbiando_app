import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proverbiando/features/saved_proverbs/presentation/provider/delete_proverb_notifier.dart';
import 'package:proverbiando/features/saved_proverbs/presentation/provider/saved_proverb_notifer.dart';
import 'package:proverbiando/util/formatter/date_formatter.dart';
import 'package:proverbiando/util/text/app_text_styles.dart';

class SavedProverbsScreen extends ConsumerWidget {
  const SavedProverbsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(savedProverbProvider);

    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0.5,
      //   backgroundColor: Theme.of(context).colorScheme.background,
      //   title: Text(
      //     'Provérbios Salvos',
      //     style: AppTextStyles.body.copyWith(
      //       fontWeight: FontWeight.bold,
      //       color: Theme.of(context).colorScheme.primary,
      //     ),
      //   ),
      //   centerTitle: true,
      // ),
      body: state.when(
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('$e - $s')),

        data: (proverb) {
          if (proverb.isEmpty) {
            return const Center(child: Text('Nenhum provérbio salvo ainda'));
          }

          return RefreshIndicator(
            onRefresh: () async {
              return ref
                  .read(savedProverbProvider.notifier)
                  .refreshSavedProverbs();
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: ListView.builder(
                itemCount: proverb.length,
                itemBuilder: (context, index) {
                  if (proverb[index].text.isEmpty) {
                    return SizedBox.shrink();
                  }

                  return Dismissible(
                    key: ValueKey(proverb[index].id),
                    direction: DismissDirection.endToStart,
                    confirmDismiss: (_) async {
                      final confirmDelete = await confirmDismiss(context);

                      if (confirmDelete) {
                        try {
                          await ref
                              .read(deleteProverbProvider.notifier)
                              .deleteProverb(proverbId: proverb[index].id!);
                          return true;
                        } catch (_) {
                          return false;
                        }
                      }
                    },

                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Card(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.bookmark_border,
                                        color: Theme.of(context).colorScheme.primary,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    '"${proverb[index].text}"',
                                    style: AppTextStyles.title.copyWith(
                                      color: Theme.of(context).colorScheme.primary,
                                      fontSize: 18,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                                Divider(indent: 20, endIndent: 20, thickness: 0.2),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 10,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        proverb[index].reference,
                                        style: AppTextStyles.title.copyWith(
                                          fontSize: 14,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.surfaceTint,
                                        ),
                                      ),
                                      Text(
                                        dateFormatter(proverb[index].addedAt!),
                                        style: AppTextStyles.body.copyWith(
                                          fontSize: 10,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.surfaceTint,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if(index ==0)
                            Text('← Deslize para apagar', style: AppTextStyles.body.copyWith(fontSize: 10, color: Theme.of(
                              context,
                            ).colorScheme.surfaceTint.withValues(alpha: 0.6),),)
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Future<bool> confirmDismiss(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Apagar provérbio?'),
          content: const Text(
            'Tem certeza que deseja remover este provérbio dos salvos?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Apagar'),
            ),
          ],
        );
      },
    );

    return result ?? false;
  }
}
