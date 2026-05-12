import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:proverbiando/core/firebase/domain/entities/proverb_entity.dart';
import 'package:proverbiando/util/text/app_text_styles.dart';

class MainCard extends StatelessWidget {
  const MainCard({
    super.key,
    required this.proverb,
    required this.refreshProverb,
    required this.saveProverb,
  });

  final ProverbEntity proverb;
  final Function refreshProverb;
  final Function saveProverb;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          elevation: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Stack(
                children: [
                  decorationMarks(context),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 40, 10, 0),
                        child: SelectableText(
                          '"${proverb.text}"',
                          style: AppTextStyles.h1.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 30),

                      Text.rich(
                        TextSpan(
                          style: AppTextStyles.body.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          children: [
                            TextSpan(text: '- '),
                            TextSpan(
                              text: proverb.reference,
                              style: AppTextStyles.body.copyWith(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            TextSpan(text: ' -'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Divider(
                          thickness: 0.15,
                          endIndent: 30,
                          indent: 30,
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () {
                              refreshProverb();
                            },
                            icon: Column(
                              children: [
                                Icon(
                                  Icons.refresh,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                Text(
                                  'Novo',
                                  style: AppTextStyles.body.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              saveProverb();
                            },
                            icon: Column(
                              children: [
                                Icon(
                                  Icons.bookmark_add_outlined,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                Text(
                                  'Salvar',
                                  style: AppTextStyles.body.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget decorationMarks(BuildContext context) {
    return Positioned(
      top: 5,
      right: 30,
      child: IgnorePointer(
        child: Text(
          '"',
          style: TextStyle(
            fontFamily: 'Catamaran',
            fontSize: 250,
            height: 1,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          ),
        ),
      ),
    );
  }
}
