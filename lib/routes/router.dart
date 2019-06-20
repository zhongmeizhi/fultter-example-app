import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
// page
import 'package:flutter_app/page/main_page.dart';
import 'package:flutter_app/page/login/login_page.dart';

class Router {

  static final Object routes = {
      "/main_page": (context) => new MainPage(),
      "/login_page": (context) => new LoginPage(title: '登录'),
      "/baidu": (context) => new WebviewScaffold(
        url: "http://www.baidu.com/",
        appBar: new AppBar(
          title: new Text("百度webview"),
          centerTitle: true, // appBar文字居中
        ),
      ),
    };
  
}