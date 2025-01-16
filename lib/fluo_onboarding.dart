import 'package:fluo/fluo.dart';
import 'package:fluo/l10n/fluo_localizations.dart';
import 'package:flutter/material.dart';

class FluoOnboarding extends StatefulWidget {
  const FluoOnboarding({
    super.key,
    required this.apiKey,
    required this.onUserReady,
    this.onInitError,
    this.introBuilder,
  });

  final String apiKey;
  final Function(Fluo fluo) onUserReady;
  final Function(Object? error)? onInitError;
  final Widget Function(
    BuildContext context,
    bool initializing,
    double bottomContainerHeight,
  )? introBuilder;

  @override
  State<FluoOnboarding> createState() => _FluoOnboardingState();
}

class _FluoOnboardingState extends State<FluoOnboarding> {
  final GlobalKey _bottomContainerKey = GlobalKey();
  double _bottomContainerHeight = 0.0;
  late Future<Fluo?> _fluoInitFuture;

  @override
  void initState() {
    super.initState();
    _fluoInitFuture = Fluo.init(widget.apiKey);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = _bottomContainerKey.currentContext!;
      final renderBox = context.findRenderObject() as RenderBox;
      final height = renderBox.size.height;
      setState(() => _bottomContainerHeight = height);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: FutureBuilder<Fluo?>(
        future: _fluoInitFuture, // ensures it's called once
        builder: (context, snapshot) {
          final fluo = snapshot.data;

          if (snapshot.hasError && widget.onInitError != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              widget.onInitError!(snapshot.error);
            });
          }

          if (fluo != null && fluo.hasSession()) {
            if (fluo.isUserComplete()) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                widget.onUserReady(fluo);
              });
            } else {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                fluo.showRegisterFlow(
                  context: context,
                  onUserReady: () => widget.onUserReady(fluo),
                );
              });
            }
          }

          Widget? introWidget;
          if (widget.introBuilder != null) {
            introWidget = widget.introBuilder!(
              context,
              fluo == null,
              _bottomContainerHeight,
            );
          }

          return Stack(
            children: [
              if (introWidget != null) introWidget,
              Align(
                alignment: Alignment.bottomCenter,
                child: IntrinsicHeight(
                  key: _bottomContainerKey,
                  child: SafeArea(
                    top: false,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 30.0,
                      ),
                      child: _connectButtons(fluo),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _connectButtons(Fluo? fluo) {
    return AnimatedOpacity(
      opacity: fluo == null ? 0.0 : 1.0,
      duration: const Duration(seconds: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
              fluo!.showConnectFlow(
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
      ),
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
        side: const BorderSide(
          color: Colors.black,
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
