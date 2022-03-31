
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
      allowUniversalAccessFromFileURLs: true,
      javaScriptEnabled: true,
      supportZoom: true,
      cacheEnabled: false,
      clearCache: true,
      preferredContentMode: UserPreferredContentMode.MOBILE,
      transparentBackground: true,
      useShouldInterceptFetchRequest: true,
      javaScriptCanOpenWindowsAutomatically: true,
      allowFileAccessFromFileURLs: true,    // upload
      useOnDownloadStart: true,             // download
      useShouldInterceptAjaxRequest: true,
      useOnLoadResource: true,
    ),
    ios: IOSInAppWebViewOptions(
      applePayAPIEnabled: true,
      useOnNavigationResponse: true,
      allowsPictureInPictureMediaPlayback: true,
      allowsAirPlayForMediaPlayback: true,
      allowsLinkPreview: true,
      isPagingEnabled: true,
      suppressesIncrementalRendering: true,
    ),
    android: AndroidInAppWebViewOptions(
      builtInZoomControls: true,
      cacheMode: AndroidCacheMode.LOAD_NO_CACHE,
      useWideViewPort: false,
      supportMultipleWindows: true,
      saveFormData: true,
      displayZoomControls: true,
      loadsImagesAutomatically: true,
      networkAvailable: true,
      useShouldInterceptRequest: true,
      useHybridComposition: true,
      useOnRenderProcessGone: true,
      domStorageEnabled: true,
      databaseEnabled: true,
      clearSessionCache: true,
      thirdPartyCookiesEnabled: true,
      allowFileAccess: true,
      allowContentAccess: true,
      disableDefaultErrorPage: true,
      safeBrowsingEnabled: true,
    ),
  );

  String url = "";
  double progress = 0;
  final urlController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InAppWebView(
        key: webViewKey,
        // download --->  https://maantst.linkdev.com/en/content/publications?IsMobile=true
        // upload --> https://maantst.linkdev.com/en/content/contact-us?IsMobile=true
        initialUrlRequest: URLRequest(
          url: Uri.parse("https://maantst.linkdev.com/en/content/contact-us?IsMobile=true"),
          iosAllowsCellularAccess: true,
          iosAllowsConstrainedNetworkAccess: true,
          iosAllowsExpensiveNetworkAccess: true,
          iosHttpShouldHandleCookies: true,
          headers: {},
        ),
        onPrint: (controller, uri) {
          print(controller.android.toString());
        },
        initialUserScripts: UnmodifiableListView<UserScript>([]),
        initialOptions: options,
        onDownloadStart: (webviewController, uri) async {
          print("onDownloadStart: $uri");
          // use any package for downloading like dio or flutter_downloader
        },
        onWebViewCreated: (controller) {
          webViewController = controller;
        },
        onLoadStart: (controller, url) {
          setState(() {
            this.url = url.toString();
            urlController.text = this.url;
          });
        },
        androidOnFormResubmission: (controller, uri) async {
          return FormResubmissionAction.RESEND;
        },
        androidOnPermissionRequest: (controller, origin, resources) async {},
        onLoadStop: (controller, url) async {
          setState(() {
            this.url = url.toString();
            urlController.text = this.url;
          });
        },
        onLoadError: (controller, url, code, message) {
          print('---------------------> $message');
        },
        onProgressChanged: (controller, progress) {
          if (progress == 100) {
          }
          setState(() {
            this.progress = progress / 100;
            urlController.text = url;
          });
        },
        onUpdateVisitedHistory: (controller, url, androidIsReload) {
          setState(() {
            this.url = url.toString();
            urlController.text = this.url;
          });
        },
        onConsoleMessage: (controller, consoleMessage) {
          print('--------> ${consoleMessage.toJson()}');
        },
      ),
    );
  }
}
