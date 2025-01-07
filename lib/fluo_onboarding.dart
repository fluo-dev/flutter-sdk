import 'package:fluo/fluo.dart';
import 'package:flutter/material.dart';

import 'l10n/fluo_localizations.dart';

class FluoOnboarding extends StatefulWidget {
  const FluoOnboarding({
    super.key,
    required this.apiKey,
    required this.onUserReady,
    this.child,
  });

  final String apiKey;
  final Function(Fluo fluo) onUserReady;
  final Widget? child;

  @override
  State<FluoOnboarding> createState() => _FluoOnboardingState();
}

class _FluoOnboardingState extends State<FluoOnboarding> {
  Fluo? _fluo;

  @override
  void initState() {
    super.initState();
    _initFluo();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: widget.child ?? Container(),
            ),
            Container(
              constraints: const BoxConstraints(
                minHeight: 280.0,
                minWidth: double.infinity,
              ),
              padding: const EdgeInsets.all(20.0),
              alignment: Alignment.center,
              child: _connectButtonsContainer(),
            ),
          ],
        ),
      ),
    );
  }

  void _initFluo() async {
    final fluo = await Fluo.init(widget.apiKey);

    final accessToken = await fluo.getAccessToken();
    if (accessToken != null) {
      widget.onUserReady(fluo);
      return;
    }

    // Here the user is not authenticated, so we need to load the app config to
    // adapt the onboarding flow to your preferences.
    await fluo.loadAppConfig();

    setState(() {
      _fluo = fluo;
    });
  }

  Widget _connectButtonsContainer() {
    if (_fluo == null) {
      return const SizedBox(
        width: 30.0,
        height: 30.0,
        child: CircularProgressIndicator(
          strokeWidth: 3.0,
        ),
      );
    }

    final fluo = _fluo!;

    return Column(
      children: [
        _connectButton(
          icon: const Icon(
            Icons.mail_outline_rounded,
            color: Colors.black,
            size: 20.0,
          ),
          title: FluoLocalizations.of(context)!.continueWithEmail,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          onPressed: () {
            fluo.showConnectFlow(
              context: context,
              onUserReady: () {
                widget.onUserReady(fluo);
              },
            );
          },
        ),
        /*
        const SizedBox(height: 15.0),
        _connectButton(
          icon: Image.asset(
            'packages/fluo/assets/images/google.png',
            width: 20.0,
          ),
          title: 'Continue with Google',
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          onPressed: () => {},
        ),
        const SizedBox(height: 15.0),
        _connectButton(
          icon: Image.asset(
            'packages/fluo/assets/images/apple.png',
            width: 20.0,
          ),
          title: 'Continue with Apple',
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          onPressed: () => {},
        ),
        */
      ],
    );
  }

  Widget _connectButton({
    required Widget icon,
    required String title,
    required Color backgroundColor,
    required Color foregroundColor,
    required Function() onPressed,
  }) {
    final theme = Theme.of(context);
    final connectButtonStyle = theme.filledButtonTheme.style!.copyWith(
      backgroundColor: WidgetStatePropertyAll(backgroundColor),
      foregroundColor: WidgetStatePropertyAll(foregroundColor),
      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: foregroundColor,
          width: 1.5,
        ),
      )),
    );

    return FilledButton(
      onPressed: onPressed,
      style: connectButtonStyle,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(width: 10.0),
          Text(title),
        ],
      ),
    );
  }
}
