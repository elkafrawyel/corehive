import 'dart:collection';
import 'dart:io';

import 'package:corehive_store/app/config/theme/color_extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../config/helpers/logging_helper.dart';

class AppWebView extends StatefulWidget {
  final String title;
  final String url;

  const AppWebView({super.key, required this.title, required this.url});

  @override
  State<AppWebView> createState() => _AppWebViewState();
}

class _AppWebViewState extends State<AppWebView> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  PullToRefreshController? pullToRefreshController;
  double progress = 0;

  @override
  void initState() {
    super.initState();

    if (!kIsWeb &&
        [
          TargetPlatform.iOS,
          TargetPlatform.android,
        ].contains(defaultTargetPlatform)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        setState(() {
          pullToRefreshController = PullToRefreshController(
            settings: PullToRefreshSettings(
              backgroundColor: context.kPrimaryColor,
              color: context.kColorOnPrimary,
            ),
            onRefresh: () async {
              if (Platform.isAndroid) {
                webViewController?.reload();
              } else if (Platform.isIOS || Platform.isMacOS) {
                final url = await webViewController?.getUrl();
                if (url != null) {
                  webViewController?.loadUrl(urlRequest: URLRequest(url: url));
                }
              }
            },
          );
        });
      });
    }
  }

  @override
  void dispose() {
    pullToRefreshController?.dispose();
    pullToRefreshController = null;
    super.dispose();
  }

  Future<bool> _handleBackNavigation() async {
    if (webViewController != null && await webViewController!.canGoBack()) {
      webViewController!.goBack();
      return false; // stay on the same screen
    }
    return true; // allow popping route
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // allow popping if we want
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return; // system already popped
        final shouldPop = await _handleBackNavigation();
        if (shouldPop && context.mounted) {
          Navigator.of(context).pop(result);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: context.kTextColor,
            ),
          ),
          backgroundColor: context.kBackgroundColor,
          elevation: 0,
          centerTitle: true,
        ),
        body: Column(
          children: [
            if (progress < 1.0)
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: LinearProgressIndicator(
                  value: progress,
                  color: context.kPrimaryColor,
                  minHeight: 5,
                ),
              ),
            Flexible(
              child: InAppWebView(
                key: webViewKey,
                initialUrlRequest: URLRequest(url: WebUri(widget.url)),
                initialUserScripts: UnmodifiableListView<UserScript>([]),
                initialSettings: InAppWebViewSettings(
                  useShouldOverrideUrlLoading: false,
                ),
                pullToRefreshController: pullToRefreshController,
                onWebViewCreated: (controller) {
                  webViewController = controller;
                },
                shouldOverrideUrlLoading: (controller, navigationAction) async {
                  return NavigationActionPolicy.ALLOW;
                },
                onLoadStop: (controller, url) async {
                  if (mounted && pullToRefreshController != null) {
                    pullToRefreshController?.endRefreshing();
                  }
                },
                onProgressChanged: (controller, p) {
                  if (!mounted) return;
                  if (p == 100 && pullToRefreshController != null) {
                    pullToRefreshController?.endRefreshing();
                  }
                  setState(() => progress = p / 100);
                },
                onConsoleMessage: (controller, consoleMessage) {
                  AppLogger.log(consoleMessage.message, useGetX: true);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
