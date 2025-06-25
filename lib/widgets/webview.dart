import 'package:fluo/fluo_theme.dart';
import 'package:fluo/widgets/round_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Webview extends StatelessWidget {
  const Webview({
    super.key,
    required this.title,
    required this.url,
    required this.onClosePressed,
  });

  final String title;
  final String url;
  final VoidCallback onClosePressed;

  @override
  Widget build(BuildContext context) {
    final fluoTheme = context.read<FluoTheme>();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 15.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: fluoTheme.modalTitleTextStyle,
              ),
              RoundButton(
                onPressed: onClosePressed,
                color: fluoTheme.primaryColor,
                iconData: Icons.close_rounded,
              ),
            ],
          ),
        ),
        Expanded(
          child: WebViewWidget(
            controller: WebViewController()..loadRequest(Uri.parse(url)),
          ),
        ),
      ],
    );
  }
}

void openWebPage({
  required BuildContext context,
  required FluoTheme theme,
  required String title,
  required String url,
}) {
  if (kIsWeb) {
    launchUrl(Uri.parse(url));
    return;
  }

  showModalBottomSheet(
    context: context,
    useSafeArea: true,
    isScrollControlled: true,
    enableDrag: false,
    builder: (context) {
      return Provider(
        create: (_) => theme,
        child: Webview(
          title: title,
          url: url,
          onClosePressed: () => Navigator.of(context).pop(),
        ),
      );
    },
  );
}
