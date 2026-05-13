import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:proverbiando/core/firebase/providers/firebase_providers.dart';
import 'package:proverbiando/features/app_update/presentation/providers/app_config_notifier.dart';
import 'package:proverbiando/util/theme/app_colors.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final appVersionStatus = ref.watch(appVersionStatusProvider);

    ref.listen(appVersionStatusProvider, (previous, next) {
      next.whenData((status) {
        if (status.requiresForceUpdate && mounted) {
          context.go('/update');
          return;
        }

        final currentUser = ref.read(currentUserProvider);
        if (currentUser.hasValue && mounted) {
          context.go('/home');
        }
      });
    });

    ref.listen(currentUserProvider, (previous, next) {
      next.when(
        data: (_) {
          final status = appVersionStatus.asData?.value;

          if (status == null || status.requiresForceUpdate) {
            return;
          }

          context.go('/home');
        },
        error: (e, s) {
          debugPrint('Error: $e - $s');
        },
        loading: () {},
      );
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              width: 130,
              child: Image.asset(
                'assets/icon/proverbiando_logo.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          if (appVersionStatus.isLoading)
            const Padding(
              padding: EdgeInsets.only(top: 24),
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
