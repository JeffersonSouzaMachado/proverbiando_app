import 'package:go_router/go_router.dart';
import 'package:proverbiando/features/home/presentation/pages/bottom_nav_screen.dart';
import 'package:proverbiando/features/splash_screen/splash_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => SplashScreen()),
    GoRoute(path: '/home', builder: (context, state) => BottomNavScreen()),
    GoRoute(path: '/saved-proverbs', builder: (context, state) => BottomNavScreen(newIndex: 1,)),
  ],
);
