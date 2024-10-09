import 'package:example/home_screen.dart';
import 'package:fluo/fluo.dart';
import 'package:flutter/material.dart';

class ConnectScreen extends StatelessWidget {
  const ConnectScreen({
    super.key,
    required this.fluo,
  });

  final Fluo fluo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(52.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Welcome',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 30),
            Text(
              'This is an example app using the Fluo SDK to onboard users. The button below starts the onboarding flow.',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 60),
            FilledButton(
              onPressed: () {
                fluo.showConnectFlow(
                  context: context,
                  onUserReady: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return const HomeScreen();
                      },
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 200),
                    ));
                  },
                );
              },
              child: const Text('Connect'),
            ),
          ],
        ),
      ),
    );
  }
}
