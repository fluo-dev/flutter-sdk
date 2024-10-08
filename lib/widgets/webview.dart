import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'round_button.dart';

class Webview extends StatefulWidget {
  const Webview({
    super.key,
    required this.url,
    required this.onClosePressed,
  });

  final String url;
  final Function() onClosePressed;

  @override
  State<Webview> createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url))
      ..setBackgroundColor(Colors.white);
  }

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
                onPressed: widget.onClosePressed,
                iconData: Icons.close_rounded,
              ),
            ],
          ),
        ),
        Expanded(
          child: WebViewWidget(controller: _controller),
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
