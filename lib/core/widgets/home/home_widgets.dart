import 'package:keno_plus/core/values/app_imports.dart';

class KenoGameModeLayout extends StatefulWidget {
  const KenoGameModeLayout({super.key});

  @override
  State<KenoGameModeLayout> createState() => _KenoGameModeLayoutState();
}

class _KenoGameModeLayoutState extends State<KenoGameModeLayout> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background carousel
        KenoGameCarousel(
          initialPage: _currentPage,
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
        ),

        // Main layout
        Column(
          children: [
            KenoTopBar(text: AppStrings.gameMode, color: AppColors.secondary),
            Spacer(),
            KenoGameBar(
              gameMode: AppGameModes.modes[_currentPage],
              currentPage: _currentPage,
              color: AppColors.secondary,
              shadowColor: AppColors.black,
            ),
          ],
        ),
      ],
    );
  }
}

class KenoGameCarousel extends StatefulWidget {
  final Function(int) onPageChanged;
  final int initialPage;

  const KenoGameCarousel({
    super.key,
    required this.onPageChanged,
    this.initialPage = 0,
  });

  @override
  State<KenoGameCarousel> createState() => _KenoGameCarouselState();
}

class _KenoGameCarouselState extends State<KenoGameCarousel> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: AppGameModes.modes.length,
      onPageChanged: widget.onPageChanged,
      itemBuilder: (context, index) {
        return KenoGameBg(imagePath: AppGameModes.modes[index].image);
      },
    );
  }
}

class KenoGameBar extends StatelessWidget {
  final GameModeStrings gameMode;
  final int _currentPage;
  final Color color;
  final Color shadowColor;

  const KenoGameBar({
    super.key,
    required this.gameMode,
    required int currentPage,
    required this.color,
    required this.shadowColor,
  }) : _currentPage = currentPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withAlpha(100),
            blurRadius: 32.0,
            spreadRadius: 8.0,
            offset: Offset(0, -16),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            KenoPageIndicator(currentPage: _currentPage),
            SizedBox(height: 8.0),
            KenoText(
              text: gameMode.title,
              fontWeight: FontWeight.w900,
              fontSize: 36.0,
              color: AppColors.black,
            ),
            SizedBox(height: 8.0),
            KenoText(text: gameMode.title, color: AppColors.black),
            SizedBox(height: 16.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 18.0),
              child: KenoButton(
                text: gameMode.buttonText,
                icon: Icons.play_arrow_rounded,
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                iconColor: AppColors.secondary,
                isGlow: true,
                glowColor: AppColors.primary,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class KenoPageIndicator extends StatelessWidget {
  final int _currentPage;

  const KenoPageIndicator({super.key, required int currentPage})
    : _currentPage = currentPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        2,
        (index) => Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                _currentPage == index
                    ? AppColors.primary
                    : AppColors.white.withAlpha(150),
          ),
        ),
      ),
    );
  }
}

class KenoTopBar extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;

  const KenoTopBar({super.key, required this.text, this.color, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            KenoText(
              text: text,
              fontFamily: AppFonts.grandstander,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.w900,
              fontSize: fontSize ?? 36.0,
              color: color ?? AppColors.secondary,
              isGlow: true,
            ),
          ],
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
  final VoidCallback onPlayPressed;
  const KenoStartLayout({super.key, required this.onPlayPressed});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(bottom: 0, left: 0, right: 0, child: KenoElementBg()),
        Positioned(
          top: 160,
          left: 0,
          right: 0,
          child: KenoStart(onPlayPressed: onPlayPressed),
        ),
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
  final VoidCallback onPlayPressed;

  const KenoStart({super.key, required this.onPlayPressed});

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
            isGlow: true,
          ),
          const SizedBox(height: 8.0),
          KenoText(
            text: AppStrings.homeSubText,
            color: AppColors.white,
            fontFamily: AppFonts.inter,
            textAlign: TextAlign.center,
            fontSize: 14.0,
          ),
          const SizedBox(height: 62.0),
          KenoButton(
            text: AppStrings.play,
            icon: Icons.play_arrow_rounded,
            textColor: AppColors.primary,
            iconColor: AppColors.white,
            isGlow: true,
            margin: 18.0,
            onPressed: onPlayPressed, // CHANGE LAYOUT TO GAME MODE
          ),
          const SizedBox(height: 16.0),
          KenoButton(
            text: AppStrings.learnKenoPlus,
            icon: Icons.question_mark_rounded,
            iconSize: 20.0,
            textColor: AppColors.secondary,
            foregroundColor: AppColors.secondary,
            backgroundColor: AppColors.transparent,
            hasBorder: true,
            borderColor: AppColors.secondary,
            margin: 18.0,
            onPressed: () {}, // CHANGE LAYOUT TO TUTORIAL
          ),
        ],
      ),
    );
  }
}
