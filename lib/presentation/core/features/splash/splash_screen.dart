import 'package:bruce_omukoko_portfolio/presentation/core/ui/reusable_widgets.dart';
import 'package:bruce_omukoko_portfolio/presentation/core/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final ValueNotifier<bool> splashNotifier = ValueNotifier(true);

  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),
      () => splashNotifier.value = false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: splashNotifier,
      builder: (_, __) {
        bool showing = splashNotifier.value;
        return Visibility(
          visible: showing,
          maintainSemantics: false,
          maintainInteractivity: false,
          maintainAnimation: false,
          maintainState: false,
          maintainSize: false,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Scaffold(
              backgroundColor: darkBackground,
              body: const InfiniteLoader(),
            ),
          ),
        );
      },
    );
  }
}

