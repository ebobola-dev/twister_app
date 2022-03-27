import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:twister_app/config.dart';
import 'package:twister_app/screens/start_screen.dart';
import 'package:twister_app/ui_funcs.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _logoController;
  late final Animation<Offset> _logoAnimation;
  Timer? _splashTimer;

  @override
  void initState() {
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _logoAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, .06),
    ).animate(_logoController)
      ..addListener(() {
        setState(() {});
      });
    _logoController.repeat(reverse: true);
    _splashTimer = Timer(const Duration(seconds: CONFIG.splashScreenTimer), () {
      animatedSwitchPage(
        context,
        const StartScreen(),
        routeAnimation: RouteAnimation.scale,
        withBack: false,
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _logoController.dispose();
    _splashTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SlideTransition(
              position: _logoAnimation,
              child: SvgPicture.asset(
                isDarkTheme(context)
                    ? "assets/svg/dark_logo.svg"
                    : "assets/svg/light_logo.svg",
              ),
            ),
            Column(
              children: [
                Text(
                  "Загрузка...",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 10),
                Lottie.asset(
                  isDarkTheme(context)
                      ? "assets/lottie/dark_circle_loading.json"
                      : "assets/lottie/light_circle_loading.json",
                  width: 100,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
