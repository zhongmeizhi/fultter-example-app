import 'package:zmz_app/page/welcome/splash_page.dart';
import 'package:zmz_app/plugin/loading.dart';
import 'package:zmz_app/plugin/toast.dart';
import 'package:zmz_app/utils/event_bus.dart';
import 'compose/compose.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zmz_app/bloc/theme_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // 国际化

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocProvider<ThemeBloc>(
      builder: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeData>(
        builder: (context, theme) {
          return MaterialApp(
            title: 'Z.金融理财',
            theme: theme,
            home: _PageManager(
              child: SplashPage()
            ),
            localizationsDelegates:  [ // 国际化代理
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('zh', 'CN'), // 中文简体
              // const Locale('en', 'US'), // 美国英语
            ],
            // routes: Router.routes , //注册路由表
          );
        },
      ),
    );
  }
}

class _PageManager extends StatelessWidget {

  final Widget child;
  _PageManager({@required this.child});

  @override
  Widget build(BuildContext context) {

    // 初始化页面 width=750; height=1334;
    ZFit.instance = ZFit(width: 375, height: 812)..init(context);

    eventBus.on('showToast', (message) {
      // 推入微任务
      Future.delayed(Duration(microseconds: 1)).then((val) {
        Toast.show(context, message);
      });
    });

    eventBus.on('showLoading', (message) {
      // 推入微任务
      Future.delayed(Duration(microseconds: 1)).then((val) {
        Loading.show(context, message);
      });
    });

    eventBus.on('closeLoading', (message) {
      // 推入微任务
      Future.delayed(Duration(microseconds: 1)).then((val) {
        Loading.close();
      });
    });

    return this.child;
  }
  
}