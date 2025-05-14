import 'dart:async';

import 'package:example/config.dart';
import 'package:fluo/fluo.dart';
import 'package:fluo/fluo_onboarding.dart';
import 'package:fluo/l10n/fluo_localizations.dart';
import 'package:fluo/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ExampleApp());
}

class ExampleApp extends StatelessWidget {
  ExampleApp({super.key});

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      theme: ThemeData(colorSchemeSeed: Colors.orange),
      localizationsDelegates: FluoLocalizations.localizationsDelegates,
      supportedLocales: FluoLocalizations.supportedLocales,
      home: FluoOnboarding(
        apiKey: Config.apiKey,
        theme: _theme(),
        introBuilder: _introScreen,
        onUserReady: _onUserReady,
      ),
    );
  }

  FluoTheme _theme() {
    return FluoTheme.native(
      primaryColor: Colors.black,
      inversePrimaryColor: Colors.white,
      connectButtonStyle: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.grey.shade200),
        foregroundColor: WidgetStateProperty.all(Colors.black),
        minimumSize: WidgetStateProperty.all(const Size(200, 54)),
        shape: WidgetStateProperty.all(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
      ),
      connectButtonStyleApple: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.black),
        foregroundColor: WidgetStateProperty.all(Colors.white),
        minimumSize: WidgetStateProperty.all(const Size(200, 54)),
        shape: WidgetStateProperty.all(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
      ),
      connectButtonIconApple: const Icon(
        Icons.apple,
        color: Colors.white,
        size: 20,
      ),
      connectButtonTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: 'SpaceGrotesk',
      ),
      connectButtonTextStyleApple: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: 'SpaceGrotesk',
      ),
      legalTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _introScreen(
    BuildContext context,
    bool initializing,
    bool signingIn,
    double bottomContainerHeight,
  ) {
    return Stack(
      children: [
        _SlidingImages(),
        Positioned(
          top: 48,
          left: 0,
          right: 0,
          child: Center(
            child: Image.asset(
              'assets/images/mclaren.png',
              width: 160,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 220,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withAlpha(200),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onUserReady(Fluo fluo) {
    _navigatorKey.currentState?.push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return Scaffold(
          backgroundColor: Colors.grey.shade200,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'You are'.toUpperCase(),
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w500,
                    fontSize: 40,
                    fontFamily: 'SpaceGrotesk',
                    height: 0.8, // Adjust this value to control line height
                    letterSpacing: -1,
                  ),
                ),
                Text(
                  'connected'.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    fontFamily: 'SpaceGrotesk',
                    letterSpacing: -1,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    ));
  }
}

class _SlidingImages extends StatefulWidget {
  @override
  State<_SlidingImages> createState() => _SlidingImagesState();
}

class _SlidingImagesState extends State<_SlidingImages>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _landoAnimation;
  late Animation<Offset> _oscarAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _landoAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(-1.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _oscarAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _startSlideSequence();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          // Lando
          SlideTransition(
            position: _landoAnimation,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  scale: 1.01,
                  image: AssetImage('assets/images/lando.png'),
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
            ),
          ),
          // Oscar
          SlideTransition(
            position: _oscarAnimation,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  scale: 1.01,
                  image: AssetImage('assets/images/oscar.png'),
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _startSlideSequence() {
    // Initial delay before first transition
    Future.delayed(const Duration(seconds: 3), () {
      _slideToOscar();
    });
  }

  void _slideToOscar() {
    _controller.forward(from: 0.0).then((_) {
      // Wait on Oscar
      Future.delayed(const Duration(seconds: 3), () {
        _slideToLando();
      });
    });
  }

  void _slideToLando() {
    _controller.reverse(from: 1.0).then((_) {
      // Wait on Lando
      Future.delayed(const Duration(seconds: 3), () {
        _slideToOscar();
      });
    });
  }
}
