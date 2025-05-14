import '../values/app_imports.dart';

class MainLayout extends StatelessWidget {
  final Widget content;

  const MainLayout({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const MainBackground(),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: content,
          ),
        ),
      ],
    );
  }
}

class KenoBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const KenoBottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: AppColors.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            pageIndex: 1,
            icon: Icons.home_rounded,
            label: AppStrings.home,
            onTap: () => context.goNamed(AppRoutes.home),
          ),
          const SizedBox(width: 24.0),
          _buildNavItem(
            pageIndex: 2,
            icon: Icons.person_rounded,
            label: AppStrings.profile,
            onTap: () => context.goNamed(AppRoutes.profile),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required int pageIndex,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return FittedBox(
      child: Column(
        children: [
          IconButton(
            icon: Icon(icon),
            iconSize: 32.0,
            color:
                currentIndex == pageIndex ? AppColors.secondary : Colors.white,
            onPressed: () {
              onTap();
            },
          ),
          Text(
            label,
            style: TextStyle(
              color:
                  currentIndex == pageIndex
                      ? AppColors.secondary
                      : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class GradientBackground extends StatelessWidget {
  const GradientBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.gradientStart, AppColors.gradientEnd],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}

class MainBackground extends StatelessWidget {
  const MainBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Image.asset(AppImages.menuBackground, fit: BoxFit.cover),
        ),
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black,
                AppColors.gradientStart.withAlpha(127),
                AppColors.gradientEnd.withAlpha(127),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    );
  }
}
