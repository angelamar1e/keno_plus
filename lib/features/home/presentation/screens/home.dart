import '../../../../core/values/app_imports.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _showGameMode = false;

  void _switchToGameMode() {
    setState(() {
      _showGameMode = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return KenoMainWidget(
      content:
          _showGameMode
              ? KenoGameModeLayout()
              : KenoStartLayout(onPlayPressed: _switchToGameMode),
    );
  }
}
