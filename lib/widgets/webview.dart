import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'round_button.dart';

class Webview extends StatelessWidget {
  const Webview({
    super.key,
    required this.url,
    required this.onClosePressed,
  });

  final String url;
  final Function() onClosePressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RoundButton(
                onPressed: onClosePressed,
                iconData: Icons.close_rounded,
              ),
            ],
          ),
        ),
        Expanded(
          child: InAppWebView(
            initialSettings: InAppWebViewSettings(
              transparentBackground: true,
            ),
            initialUrlRequest: URLRequest(
              url: WebUri(url),
            ),
          ),
        ),
      ],
    );
  }
}

void showWebviewDialog(BuildContext context, String url) {
  showModalBottomSheet(
    context: context,
    barrierColor: Theme.of(context).colorScheme.surface,
    useSafeArea: true,
    isScrollControlled: true,
    enableDrag: false,
    builder: (context) {
      return Webview(
        url: url,
        onClosePressed: () => Navigator.of(context).pop(),
      );
    },
  );
}
