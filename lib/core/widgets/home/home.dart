import 'package:keno_plus/core/values/app_imports.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KenoMainLayout(
      content: Stack(
        fit: StackFit.expand,
        children: [
          // Background carousel
          PageView.builder(
            controller: _pageController,
            itemCount: AppGameModes.modes.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return KenoGameBg(imagePath: AppGameModes.modes[index].image);
            },
          ),

          Column(
            children: [
              KenoTopBar(),
              Spacer(),
              // Bottom bar that changes with the carousel
              KenoGameBar(gameMode: AppGameModes.modes[_currentPage]),
            ],
          ),

          // Page indicator dots
          Positioned(
            bottom: 200, // Position above the game bar
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                AppGameModes.modes.length,
                (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        _currentPage == index
                            ? AppColors.secondary
                            : AppColors.white.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class KenoGameBar extends StatelessWidget {
  final GameMode gameMode;

  const KenoGameBar({super.key, required this.gameMode});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withAlpha(100),
            blurRadius: 16.0,
            spreadRadius: 4.0,
            offset: Offset(0, -10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 26.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            KenoText(
              text: gameMode.title,
              fontWeight: FontWeight.w900,
              fontSize: 36.0,
              color: AppColors.black,
            ),
            SizedBox(height: 8.0),
            KenoText(text: gameMode.description, color: AppColors.black),
            SizedBox(height: 16.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 18.0),
              child: KenoMainButton(
                text: gameMode.buttonText,
                icon: Icons.play_arrow_rounded,
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                iconColor: AppColors.secondary,
                showGlow: false,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class KenoTopBar extends StatelessWidget {
  const KenoTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 30.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.transparent],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              KenoText(
                text: AppStrings.gameMode,
                fontFamily: AppFonts.grandstander,
                textAlign: TextAlign.start,
                fontWeight: FontWeight.w900,
                fontSize: 36.0,
                color: AppColors.secondary,
                glow: true,
              ),
              const SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
    );
  }
}

class KenoGameBg extends StatelessWidget {
  final String imagePath;

  const KenoGameBg({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
  }
}

// FIRST PAGE
class KenoStartLayout extends StatelessWidget {
  const KenoStartLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(bottom: 0, left: 0, right: 0, child: KenoElementBg()),
        Positioned(top: 72, left: 0, right: 0, child: KenoStart()),
      ],
    );
  }
}

class KenoElementBg extends StatelessWidget {
  const KenoElementBg({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(AppImages.elementBg, fit: BoxFit.contain);
  }
}

class KenoStart extends StatelessWidget {
  const KenoStart({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          KenoText(
            text: AppStrings.homeMainText,
            fontFamily: AppFonts.grandstander,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w900,
            fontSize: 36.0,
            color: AppColors.secondary,
          ),
          const SizedBox(height: 8.0),
          KenoText(
            text: AppStrings.homeSubText,
            fontFamily: AppFonts.inter,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 100.0),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 28.0),
            child: KenoMainButton(
              text: AppStrings.learnKenoPlus,
              icon: Icons.play_arrow_rounded,
              onPressed: () {}, // CHANGE LAYOUT TO GAME MODE
            ),
          ),
        ],
      ),
    );
  }
}
