import 'dart:io';

import 'package:fluo/api/models/auth_method.dart';
import 'package:fluo/fluo.dart';
import 'package:fluo/fluo_theme.dart';
import 'package:fluo/l10n/fluo_localizations.dart';
import 'package:fluo/managers/country_manager.dart';
import 'package:fluo/widgets/webview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';

import 'stubs/google_sign_in_web_stub.dart'
    if (dart.library.html) 'package:google_sign_in_web/google_sign_in_web.dart';

class FluoOnboarding extends StatefulWidget {
  const FluoOnboarding({
    super.key,
    required this.fluoTheme,
    this.onUserReady,
    this.introBuilder,
  });

  final FluoTheme fluoTheme;
  final VoidCallback? onUserReady;
  final Widget Function(
    BuildContext context,
    double bottomContainerHeight,
  )? introBuilder;

  @override
  State<FluoOnboarding> createState() => _FluoOnboardingState();
}

class _FluoOnboardingState extends State<FluoOnboarding> {
  final GlobalKey _bottomContainerKey = GlobalKey();
  final Map<String, bool> _authMethods = {};
  double _bottomContainerHeight = 0.0;
  bool _connectContainerVisible = false;
  Widget? _googleButtonForWeb;
  bool _showGoogleButtonForWeb = false; // used to prevent clicks
  bool _creatingSessionWithGoogle = false;
  bool _creatingSessionWithApple = false;

  @override
  void initState() {
    super.initState();

    for (final method in Fluo.instance.appConfig.authMethods) {
      if (method.id == AuthMethodId.apple) {
        // Sign in with Apple is only available on iOS
        _authMethods[method.id] = method.selected && !kIsWeb && Platform.isIOS;
      } else {
        _authMethods[method.id] = method.selected;
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Check for existing session first
      if (Fluo.instance.hasSession()) {
        // Double-checking whether user is ready. Usually, it is recommended
        // to check this before using FluoOnboarding, to avoid building a
        // whole screen for no reason.
        if (Fluo.instance.isUserReady()) {
          widget.onUserReady?.call();
        } else if (mounted) {
          Fluo.instance.showRegisterFlow(
            context: context,
            theme: widget.fluoTheme,
            onUserReady: () => widget.onUserReady?.call(),
          );
        }
        // Exit early if we have a session
        return;
      }

      // Measure height to pass it to the introBuilder.
      final renderBoxContext = _bottomContainerKey.currentContext!;
      final renderBox = renderBoxContext.findRenderObject() as RenderBox;
      final height = renderBox.size.height;
      setState(() => _bottomContainerHeight = height);

      // That's used to fade in the connect container.
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() => _connectContainerVisible = true);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget? introWidget;
    if (widget.introBuilder != null) {
      introWidget = widget.introBuilder!(
        context,
        _bottomContainerHeight,
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          if (introWidget != null) introWidget,
          Align(
            alignment: kIsWeb ? Alignment.center : Alignment.bottomCenter,
            child: IntrinsicHeight(
              key: _bottomContainerKey,
              child: Container(
                padding: widget.fluoTheme.screenPadding,
                child: _connectContainer(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _showConnectContainer() {
    final showGoogleButton = _authMethods[AuthMethodId.google] ?? false;
    if (showGoogleButton && kIsWeb) {
      return _connectContainerVisible && _showGoogleButtonForWeb;
    }
    return _connectContainerVisible;
  }

  Widget _connectContainer() {
    final emailSelected = _authMethods[AuthMethodId.email] ?? false;
    final mobileSelected = _authMethods[AuthMethodId.mobile] ?? false;
    final googleSelected = _authMethods[AuthMethodId.google] ?? false;
    final appleSelected = _authMethods[AuthMethodId.apple] ?? false;

    if (mobileSelected) {
      // Load countries from libphonenumber
      CountryManager.init();
    }

    return AnimatedOpacity(
      opacity: _showConnectContainer() ? 1.0 : 0.01,
      duration: const Duration(milliseconds: 300),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            spacing: 15.0,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (emailSelected)
                _connectButton(
                  icon: widget.fluoTheme.connectButtonIconEmail,
                  title: FluoLocalizations.of(context)!.continueWithEmail,
                  buttonStyle: widget.fluoTheme.connectButtonStyle,
                  textStyle: widget.fluoTheme.connectButtonTextStyle,
                  onPressed: () {
                    Future.delayed(const Duration(milliseconds: 300), () {
                      setState(() => _showGoogleButtonForWeb = false);
                    });
                    Fluo.instance.showConnectWithEmailFlow(
                      context: context,
                      theme: widget.fluoTheme,
                      onExit: () {
                        Future.delayed(const Duration(milliseconds: 300), () {
                          setState(() => _showGoogleButtonForWeb = true);
                        });
                      },
                      onUserReady: () {
                        setState(() => _showGoogleButtonForWeb = true);
                        widget.onUserReady?.call();
                      },
                    );
                  },
                ),
              if (mobileSelected)
                _connectButton(
                  icon: widget.fluoTheme.connectButtonIconMobile,
                  title: FluoLocalizations.of(context)!.continueWithMobile,
                  buttonStyle: widget.fluoTheme.connectButtonStyle,
                  textStyle: widget.fluoTheme.connectButtonTextStyle,
                  onPressed: () {
                    Future.delayed(const Duration(milliseconds: 300), () {
                      setState(() => _showGoogleButtonForWeb = false);
                    });
                    Fluo.instance.showConnectWithMobileFlow(
                      context: context,
                      theme: widget.fluoTheme,
                      onExit: () {
                        Future.delayed(const Duration(milliseconds: 300), () {
                          setState(() => _showGoogleButtonForWeb = true);
                        });
                      },
                      onUserReady: () {
                        setState(() => _showGoogleButtonForWeb = true);
                        widget.onUserReady?.call();
                      },
                    );
                  },
                ),
              if (googleSelected && kIsWeb)
                SizedBox(
                  height: 40.0, // because GSIButtonSize.large is 40px tall
                  child: _connectButtonForGoogleWeb(),
                ),
              if (googleSelected && !kIsWeb)
                _connectButton(
                  icon: widget.fluoTheme.connectButtonIconGoogle,
                  title: FluoLocalizations.of(context)!.continueWithGoogle,
                  buttonStyle: widget.fluoTheme.connectButtonStyleGoogle,
                  textStyle: widget.fluoTheme.connectButtonTextStyleGoogle,
                  loading: _creatingSessionWithGoogle,
                  onPressed: () async {
                    await Fluo.instance.showConnectWithGoogleFlow(
                      context: context,
                      theme: widget.fluoTheme,
                      onBeforeSessionCreation: () {
                        setState(() => _creatingSessionWithGoogle = true);
                      },
                      onUserReady: () {
                        widget.onUserReady?.call();
                      },
                    );
                  },
                ),
              if (appleSelected)
                _connectButton(
                  icon: widget.fluoTheme.connectButtonIconApple,
                  title: FluoLocalizations.of(context)!.continueWithApple,
                  buttonStyle: widget.fluoTheme.connectButtonStyleApple,
                  textStyle: widget.fluoTheme.connectButtonTextStyleApple,
                  loading: _creatingSessionWithApple,
                  onPressed: () async {
                    await Fluo.instance.showConnectWithAppleFlow(
                      context: context,
                      theme: widget.fluoTheme,
                      onBeforeSessionCreation: () {
                        setState(() => _creatingSessionWithApple = true);
                      },
                      onUserReady: () {
                        widget.onUserReady?.call();
                      },
                    );
                  },
                ),
            ],
          ),
          Padding(
            padding: widget.fluoTheme.legalTextPadding,
            child: StyledText(
              text: FluoLocalizations.of(context)!.acceptTerms,
              textAlign: TextAlign.center,
              style: widget.fluoTheme.legalTextStyle,
              tags: {
                'terms': StyledTextActionTag(
                  (text, attrs) => openWebPage(
                    context: context,
                    theme: widget.fluoTheme,
                    title: FluoLocalizations.of(context)!.termsAndConditions,
                    url: Fluo.instance.appConfig.termsUrl,
                  ),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                    decorationColor: widget.fluoTheme.legalTextStyle.color,
                  ),
                ),
                'privacy': StyledTextActionTag(
                  (text, attrs) => openWebPage(
                    context: context,
                    theme: widget.fluoTheme,
                    title: FluoLocalizations.of(context)!.privacyPolicy,
                    url: Fluo.instance.appConfig.privacyUrl,
                  ),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                    decorationColor: widget.fluoTheme.legalTextStyle.color,
                  ),
                ),
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _connectButton({
    required Widget icon,
    required String title,
    required ButtonStyle buttonStyle,
    required TextStyle textStyle,
    required VoidCallback onPressed,
    bool loading = false,
  }) {
    List<Widget> children = [];
    if (loading) {
      children = [
        SizedBox(
          width: textStyle.fontSize,
          height: textStyle.fontSize,
          child: CircularProgressIndicator(
            color: textStyle.color,
            strokeWidth: 2.0,
          ),
        ),
      ];
    } else {
      children = [
        icon,
        const SizedBox(width: 10.0),
        Text(title, style: textStyle),
      ];
    }

    final creatingSession =
        _creatingSessionWithGoogle || _creatingSessionWithApple;

    return FilledButton(
      onPressed: creatingSession ? null : onPressed,
      style: buttonStyle,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
    );
  }

  Widget _connectButtonForGoogleWeb() {
    var googleButtonForWeb = _googleButtonForWeb;
    if (googleButtonForWeb == null) {
      _initGoogleButtonForWeb();
      googleButtonForWeb = _connectButton(
        icon: widget.fluoTheme.connectButtonIconGoogle,
        title: FluoLocalizations.of(context)!.continueWithGoogle,
        buttonStyle: widget.fluoTheme.connectButtonStyleGoogle,
        textStyle: widget.fluoTheme.connectButtonTextStyleGoogle,
        onPressed: () {},
      );
    }
    return googleButtonForWeb;
  }

  Future<void> _initGoogleButtonForWeb() async {
    final googleSignInPlugin = GoogleSignInPlugin();
    await googleSignInPlugin.init(
      clientId: Fluo.instance.getGoogleClientId(),
      scopes: ['email'],
    );

    googleSignInPlugin.userDataEvents?.listen((data) {
      final buildContext = context;
      final googleIdToken = data?.idToken;
      if (!buildContext.mounted || googleIdToken == null) {
        return;
      }
      Fluo.instance.createSession(
        context: buildContext,
        theme: widget.fluoTheme,
        googleIdToken: googleIdToken,
        onUserReady: () {
          widget.onUserReady?.call();
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
      setState(() => _showGoogleButtonForWeb = true);
    });
  }
}
