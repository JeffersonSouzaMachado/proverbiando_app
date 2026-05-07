import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proverbiando/features/saved_proverbs/presentation/provider/saved_proverb_notifer.dart';
import 'package:proverbiando/util/formatter/date_formatter.dart';
import 'package:proverbiando/util/text/app_text_styles.dart';

class SavedProverbsScreen extends ConsumerWidget {
  const SavedProverbsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(savedProverbProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          'Provérbios Salvos',
          style: AppTextStyles.body.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        centerTitle: true,
      ),
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
            child: ListView.builder(
              itemCount: proverb.length,
              itemBuilder: (context, index) {
                if (proverb[index].text.isEmpty) {
                  return SizedBox.shrink();
                }

                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.bookmark_remove_outlined,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
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
                );
              },
            ),
          );
        },
      ),
    );
  }
}
