import 'dart:io';

import 'package:fluo/api/models/auth_method.dart';
import 'package:fluo/fluo.dart';
import 'package:fluo/l10n/fluo_localizations.dart';
import 'package:fluo/theme.dart';
import 'package:fluo/widgets/webview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in_web/google_sign_in_web.dart';
import 'package:styled_text/styled_text.dart';

class FluoOnboarding extends StatefulWidget {
  FluoOnboarding({
    super.key,
    required this.apiKey,
    required this.onUserReady,
    this.onInitError,
    this.introBuilder,
    FluoTheme? theme,
  }) : theme = theme ?? FluoTheme();

  final String apiKey;
  final Function(Fluo fluo) onUserReady;
  final Function(Object? error)? onInitError;
  final Widget Function(
    BuildContext context,
    bool initializing,
    bool signingIn,
    double bottomContainerHeight,
  )? introBuilder;
  final FluoTheme theme;

  @override
  State<FluoOnboarding> createState() => _FluoOnboardingState();
}

class _FluoOnboardingState extends State<FluoOnboarding> {
  final GlobalKey _bottomContainerKey = GlobalKey();
  double _bottomContainerHeight = 0.0;
  late Future<Fluo?> _initFluoFuture;
  Widget? _googleButtonForWeb;
  bool _googleButtonForWebReady = false;
  bool _signingIn = false;

  @override
  void initState() {
    super.initState();

    _initFluoFuture = Future.microtask(() {
      return Fluo.init(widget.apiKey);
    });

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
      body: FutureBuilder<Fluo?>(
        future: _initFluoFuture, // ensures it's called once
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
                  theme: widget.theme,
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
              _signingIn,
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
                      padding: widget.theme.screenPadding,
                      child: _signingIn ? Container() : _connectContainer(fluo),
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

  bool _showConnectContainer(Fluo? fluo) {
    if (kIsWeb) {
      return fluo != null && _googleButtonForWebReady;
    }
    return fluo != null;
  }

  Widget _connectContainer(Fluo? fluo) {
    bool showEmailButton = false;
    bool showGoogleButton = false;
    bool showAppleButton = false;

    if (fluo != null) {
      for (final method in fluo.appConfig.authMethods) {
        if (method.id == AuthMethodId.email) {
          showEmailButton = method.selected;
        } else if (method.id == AuthMethodId.google) {
          showGoogleButton = method.selected;
        } else if (method.id == AuthMethodId.apple &&
            !kIsWeb &&
            Platform.isIOS) {
          showAppleButton = method.selected;
        }
      }
    }

    return AnimatedOpacity(
      opacity: _showConnectContainer(fluo) ? 1.0 : 0.01,
      duration: const Duration(seconds: 2),
      child: Column(
        spacing: 15.0,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (showEmailButton)
            _connectButton(
              icon: widget.theme.connectButtonIconEmail,
              title: FluoLocalizations.of(context)!.continueWithEmail,
              buttonStyle: widget.theme.connectButtonStyle,
              textStyle: widget.theme.connectButtonTextStyle,
              onPressed: () {
                Future.delayed(const Duration(milliseconds: 300), () {
                  setState(() {
                    _signingIn = true;
                    _googleButtonForWebReady = false;
                  });
                });
                fluo!.showConnectWithEmailFlow(
                  context: context,
                  theme: widget.theme,
                  onExit: () {
                    setState(() => _signingIn = false);
                    Future.delayed(const Duration(milliseconds: 300), () {
                      setState(() => _googleButtonForWebReady = true);
                    });
                  },
                  onUserReady: () {
                    setState(() {
                      _signingIn = false;
                      _googleButtonForWebReady = true;
                    });
                    widget.onUserReady(fluo);
                  },
                );
              },
            ),
          if (showGoogleButton && kIsWeb)
            SizedBox(
              height: 40.0, // because GSIButtonSize.large is 40px tall
              child: _connectButtonForGoogleWeb(fluo!),
            ),
          if (showGoogleButton && !kIsWeb)
            _connectButton(
              icon: widget.theme.connectButtonIconGoogle,
              title: FluoLocalizations.of(context)!.continueWithGoogle,
              buttonStyle: widget.theme.connectButtonStyleGoogle,
              textStyle: widget.theme.connectButtonTextStyleGoogle,
              onPressed: () async {
                Future.delayed(const Duration(milliseconds: 300), () {
                  setState(() => _signingIn = true);
                });
                final success = await fluo!.showConnectWithGoogleFlow(
                  context: context,
                  theme: widget.theme,
                  onUserReady: () {
                    widget.onUserReady(fluo);
                  },
                );
                Future.delayed(Duration(milliseconds: success ? 300 : 0), () {
                  setState(() => _signingIn = false);
                });
              },
            ),
          if (showAppleButton)
            _connectButton(
              icon: widget.theme.connectButtonIconApple,
              title: FluoLocalizations.of(context)!.continueWithApple,
              buttonStyle: widget.theme.connectButtonStyleApple,
              textStyle: widget.theme.connectButtonTextStyleApple,
              onPressed: () async {
                Future.delayed(const Duration(milliseconds: 300), () {
                  setState(() => _signingIn = true);
                });
                final success = await fluo!.showConnectWithAppleFlow(
                  context: context,
                  theme: widget.theme,
                  onUserReady: () {
                    widget.onUserReady(fluo);
                  },
                );
                Future.delayed(Duration(milliseconds: success ? 300 : 0), () {
                  setState(() => _signingIn = false);
                });
              },
            ),
          Padding(
            padding: widget.theme.legalTextPadding,
            child: StyledText(
              text: FluoLocalizations.of(context)!.acceptTerms,
              textAlign: TextAlign.center,
              style: widget.theme.legalTextStyle,
              tags: {
                'terms': StyledTextActionTag(
                  (text, attrs) => openWebPage(
                    context: context,
                    theme: widget.theme,
                    title: FluoLocalizations.of(context)!.termsAndConditions,
                    url: fluo!.appConfig.termsUrl,
                  ),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                    decorationColor: widget.theme.legalTextStyle.color,
                  ),
                ),
                'privacy': StyledTextActionTag(
                  (text, attrs) => openWebPage(
                    context: context,
                    theme: widget.theme,
                    title: FluoLocalizations.of(context)!.privacyPolicy,
                    url: fluo!.appConfig.privacyUrl,
                  ),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                    decorationColor: widget.theme.legalTextStyle.color,
                  ),
                ),
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _connectButton({
    required Widget icon,
    required String title,
    required ButtonStyle buttonStyle,
    required TextStyle textStyle,
    required Function() onPressed,
  }) {
    return FilledButton(
      onPressed: onPressed,
      style: buttonStyle,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(width: 10.0),
          Text(
            title,
            style: textStyle,
          ),
        ],
      ),
    );
  }

  Widget _connectButtonForGoogleWeb(Fluo fluo) {
    var googleButtonForWeb = _googleButtonForWeb;
    if (googleButtonForWeb == null) {
      _initGoogleButtonForWeb(fluo);
      googleButtonForWeb = _connectButton(
        icon: widget.theme.connectButtonIconGoogle,
        title: FluoLocalizations.of(context)!.continueWithGoogle,
        buttonStyle: widget.theme.connectButtonStyleGoogle,
        textStyle: widget.theme.connectButtonTextStyleGoogle,
        onPressed: () {},
      );
    }

    return googleButtonForWeb;
  }

  Future<void> _initGoogleButtonForWeb(Fluo fluo) async {
    final googleSignInPlugin = GoogleSignInPlugin();
    await googleSignInPlugin.init(
      clientId: fluo.getGoogleClientId(),
      scopes: ['email'],
    );

    googleSignInPlugin.userDataEvents?.listen((data) {
      final buildContext = context;
      final googleIdToken = data?.idToken;
      if (!buildContext.mounted || googleIdToken == null) {
        return;
      }
      fluo.createSession(
        context: buildContext,
        theme: widget.theme,
        googleIdToken: googleIdToken,
        onUserReady: () {
          widget.onUserReady(fluo);
        },
      );
    });

    String? locale;
    final buildContext = context;
    if (buildContext.mounted) {
      locale = FluoLocalizations.of(buildContext)!.localeName;
    }

    final googleButtonForWeb = googleSignInPlugin.renderButton(
      configuration: GSIButtonConfiguration(
        theme: GSIButtonTheme.outline,
        type: GSIButtonType.standard,
        shape: GSIButtonShape.rectangular,
        text: GSIButtonText.continueWith,
        size: GSIButtonSize.large,
        locale: locale,
        logoAlignment: GSIButtonLogoAlignment.center,
        minimumWidth: 360,
      ),
    );

    setState(() => _googleButtonForWeb = googleButtonForWeb);

    // The button is rendered asynchronously using a FutureBuilder,
    // so we need to wait a little to avoid seeing a flash of the button.
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() => _googleButtonForWebReady = true);
    });
  }
}
