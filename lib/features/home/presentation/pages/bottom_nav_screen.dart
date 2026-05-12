import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proverbiando/core/analytics/analytics_events.dart';
import 'package:proverbiando/core/analytics/analytics_provider.dart';
import 'package:proverbiando/features/home/presentation/pages/homepage.dart';
import 'package:proverbiando/features/saved_proverbs/presentation/page/saved_proverbs_screen.dart';
import 'package:proverbiando/util/text/app_text_styles.dart';

class BottomNavScreen extends ConsumerStatefulWidget {
  const BottomNavScreen({super.key, this.newIndex = 0});

  final int newIndex;

  @override
  ConsumerState<BottomNavScreen> createState() => _BottomNavScreen();
}

class _BottomNavScreen extends ConsumerState<BottomNavScreen> {
  int currentIndex = 0;
  final pages = const [Homepage(), SavedProverbsScreen()];

  @override
  void initState() {
    currentIndex = widget.newIndex;

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _logScreenView(currentIndex);
    });
  }

  String _screenNameFor(int index) {
    return index == 0 ? 'home' : 'saved_proverbs';
  }

  String _tabNameFor(int index) {
    return index == 0 ? 'home' : 'saved';
  }

  Future<void> _logScreenView(int index) {
    return ref
        .read(analyticsServiceProvider)
        .logScreenView(_screenNameFor(index));
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(child: pages[currentIndex]),

      bottomNavigationBar: BottomNavigationBar(
        elevation: 3,
        currentIndex: currentIndex,
        onTap: (index) async {
          if (index == currentIndex) {
            return;
          }

          setState(() => currentIndex = index);

          final analytics = ref.read(analyticsServiceProvider);
          await analytics.logEvent(
            AnalyticsEvents.bottomNavTabChanged,
            parameters: {'tab_name': _tabNameFor(index)},
          );
          await analytics.logScreenView(_screenNameFor(index));
        },

        type: BottomNavigationBarType.fixed,

        selectedItemColor: colors.primary,
        unselectedItemColor: colors.onSurface.withValues(alpha: 0.5),
        selectedLabelStyle: AppTextStyles.body.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            activeIcon: Icon(Icons.bookmark),
            label: 'Salvos',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.favorite_border),
          //   activeIcon: Icon(Icons.favorite),
          //   label: 'Favoritos',
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.person_outline),
          //   activeIcon: Icon(Icons.person),
          //   label: 'Perfil',
          // ),
        ],
      ),
    );
  }
}
