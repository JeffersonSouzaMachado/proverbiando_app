import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proverbiando/core/firebase/domain/entities/app_config_entity.dart';
import 'package:proverbiando/util/services/app_launch_service.dart';
import 'package:proverbiando/util/text/app_text_styles.dart';

class UpdateScreen extends ConsumerWidget {
  const UpdateScreen({super.key, required this.appConfig});

  final AppConfigEntity appConfig;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                appConfig.titleMessage,
                style: AppTextStyles.h1.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Text(
                  appConfig.messageContent,
                  style: AppTextStyles.body,
                  textAlign: TextAlign.center,
                ),
              ),
              FilledButton(
                onPressed: () {
                  openPlayStore(appConfig.storeUrl);
                },
                child: const Text('Atualizar na Loja'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
