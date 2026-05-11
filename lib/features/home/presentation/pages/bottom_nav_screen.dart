import 'package:flutter/material.dart';
import 'package:proverbiando/features/home/presentation/pages/homepage.dart';
import 'package:proverbiando/features/saved_proverbs/presentation/page/saved_proverbs_screen.dart';
import 'package:proverbiando/util/text/app_text_styles.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key, this.newIndex = 0});

  final int newIndex;

  @override
  State<BottomNavScreen> createState() => _BottomNavScreen();
}

class _BottomNavScreen extends State<BottomNavScreen> {
  int currentIndex = 0;

  @override
  void initState() {
    currentIndex = widget.newIndex;

    super.initState();
  }

  final pages = [Homepage(), SavedProverbsScreen()];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(child: pages[currentIndex]),

      bottomNavigationBar: BottomNavigationBar(
        elevation: 3,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() => currentIndex = index);
        },

        type: BottomNavigationBarType.fixed,

        selectedItemColor: colors.primary,
        unselectedItemColor: colors.onSurface.withOpacity(0.5),
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
