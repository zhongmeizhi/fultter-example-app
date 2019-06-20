import 'package:flutter/material.dart';
// 页面
import 'package:flutter_app/page/welcome/splash_page.dart';
// 路由
import 'package:flutter_app/routes/router.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Z.金融理财',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false, // 不显示Debug图标
      routes:Router.routes , //注册路由表
      home: new SplashScreen(),
    );
  }
}


