import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

import 'package:zmz_app/utils/event_bus.dart';
// import 'package:zmz_app/view/my_search.dart';

class FundSelectionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FundState();
}

class FundState extends State<FundSelectionPage> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  // var _searchValue;

  final Completer<WebViewController> _controller = Completer<WebViewController>();
    
  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    // 在JS中可用调用 Toaster.postMessage('msg');
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    eventBus.emit('showLoading', '加载中...');

    return Container(
      width: 300,
      height: 400,
      child: WebView(
            initialUrl: 'https://zhongmeizhi.github.io/FED-note/',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            javascriptChannels: <JavascriptChannel>[
              _toasterJavascriptChannel(context),
            ].toSet(),
            navigationDelegate: (NavigationRequest request) {
              // URL拦截
              if (request.url == 'https://www.baidu.com/') {
                // 组织链接跳转
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
            onPageFinished: (String url) {
              eventBus.emit('closeLoading');
            },
          )
    );
  }
}