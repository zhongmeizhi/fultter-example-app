import 'package:flutter/material.dart';
import 'package:zmz_app/routes/router.dart'; // 路由
import 'package:zmz_app/bloc/provider.dart'; // provider
import 'package:zmz_app/bloc/count_bloc.dart'; // Bloc注入
// 页面
import 'package:zmz_app/page/welcome/splash_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new BlocProvider( // Bloc注入
      bloc: new CounterBloc(), // 主Bloc
      child: new MaterialApp(
        title: 'Z.金融理财',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false, // 不显示Debug图标
        routes: Router.routes , //注册路由表
        home: new SplashScreen()
      )
    );
  }
}


