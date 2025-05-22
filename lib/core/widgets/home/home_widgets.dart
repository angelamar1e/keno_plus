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
    final colorScheme = Theme.of(context).colorScheme;
    
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
            KenoTopBar(
              text: AppStrings.gameMode,
              textColor: colorScheme.secondary,
            ),
            Spacer(),
            KenoGameBar(
              gameMode: AppGameModes.modes[_currentPage],
              currentPage: _currentPage,
              color: colorScheme.secondary,
              shadowColor: colorScheme.shadow,
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
  final GameMode gameMode;
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
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withAlpha(100),
            blurRadius: 32.0,
            spreadRadius: 8.0,
            offset: const Offset(0, -16),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            KenoPageIndicator(currentPage: _currentPage),
            const SizedBox(height: 8.0),
            KenoText(
              text: gameMode.title,
              fontWeight: FontWeight.w900,
              fontSize: 36.0,
              color: colorScheme.onSecondary,
            ),
            const SizedBox(height: 8.0),
            KenoText(
              text: gameMode.description, 
              color: colorScheme.onSecondary
            ),
            const SizedBox(height: 16.0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18.0),
              child: KenoButton(
                text: gameMode.buttonText,
                icon: Icons.play_arrow_rounded,
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                iconColor: colorScheme.secondary,
                isGlow: true,
                glowColor: colorScheme.primary,
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
    final colorScheme = Theme.of(context).colorScheme;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        AppGameModes.modes.length,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                _currentPage == index
                    ? colorScheme.primary
                    : colorScheme.onSecondary.withAlpha(150),
          ),
        ),
      ),
    );
  }
}

class KenoTopBar extends StatelessWidget {
  final String text;
  final Color textColor;

  const KenoTopBar({super.key, required this.text, required this.textColor});
  
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      padding: const EdgeInsets.only(bottom: 128.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primary, 
            colorScheme.background.withOpacity(0)
          ],
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
                text: text,
                fontFamily: AppFonts.grandstander,
                textAlign: TextAlign.start,
                fontWeight: FontWeight.w900,
                fontSize: 36.0,
                color: textColor,
                isGlow: true,
              ),
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
    final colorScheme = Theme.of(context).colorScheme;
    
    return Image.asset(
      imagePath,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      color: colorScheme.brightness == Brightness.dark ? 
          null : colorScheme.surface.withOpacity(0.1),
      colorBlendMode: BlendMode.darken,
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
    final colorScheme = Theme.of(context).colorScheme;
    
    return Image.asset(
      AppImages.elementBg, 
      fit: BoxFit.contain,
      color: colorScheme.brightness == Brightness.dark ?
          null : colorScheme.surface.withOpacity(0.1),
      colorBlendMode: BlendMode.darken,
    );
  }
}

class KenoStart extends StatelessWidget {
  final VoidCallback onPlayPressed;

  const KenoStart({super.key, required this.onPlayPressed});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
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
            color: colorScheme.secondary,
            isGlow: true,
          ),
          const SizedBox(height: 8.0),
          KenoText(
            text: AppStrings.homeSubText,
            color: colorScheme.onBackground,
            fontFamily: AppFonts.inter,
            textAlign: TextAlign.center,
            fontSize: 14.0,
          ),
          const SizedBox(height: 62.0),
          KenoButton(
            text: AppStrings.play,
            icon: Icons.play_arrow_rounded,
            textColor: colorScheme.primary,
            iconColor: colorScheme.onPrimary,
            backgroundColor: colorScheme.secondary,
            isGlow: true,
            glowColor: colorScheme.secondary,
            margin: 18.0,
            onPressed: onPlayPressed, // CHANGE LAYOUT TO GAME MODE
          ),
          const SizedBox(height: 16.0),
          KenoButton(
            text: AppStrings.learnKenoPlus,
            icon: Icons.question_mark_rounded,
            iconSize: 20.0,
            textColor: colorScheme.secondary,
            foregroundColor: colorScheme.secondary,
            backgroundColor: Colors.transparent,
            hasBorder: true,
            borderColor: colorScheme.secondary,
            margin: 18.0,
            onPressed: () {}, // CHANGE LAYOUT TO TUTORIAL
          ),
        ],
      ),
    );
  }
}
