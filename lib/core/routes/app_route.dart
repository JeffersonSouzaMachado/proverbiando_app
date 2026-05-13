import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:proverbiando/features/app_update/presentation/pages/force_update_screen.dart';
import 'package:proverbiando/features/app_update/presentation/providers/app_config_notifier.dart';
import 'package:proverbiando/features/home/presentation/pages/bottom_nav_screen.dart';
import 'package:proverbiando/features/splash_screen/splash_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: '/update',
      builder: (context, state) {
        final container = ProviderScope.containerOf(context);
        final status = container.read(appVersionStatusProvider).asData?.value;

        if (status == null) {
          return const SplashScreen();
        }

        return UpdateScreen(appConfig: status.appConfig);
      },
    ),
    GoRoute(path: '/home', builder: (context, state) => const BottomNavScreen()),
    GoRoute(
      path: '/saved-proverbs',
      builder: (context, state) => const BottomNavScreen(newIndex: 1),
    ),
  ],
);
