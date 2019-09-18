import 'compose/compose.dart';
import 'package:zmz_app/config/base_info.dart';
import 'package:zmz_app/page/manager_page.dart';
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

class MyApp extends StatelessWidget {

  MyApp(Env env) {
    // bloc控制
    BlocSupervisor.delegate = SimpleBlocDelegate();
    // 设置环境变量
    Config.setEnv = env;
  }


  @override
  Widget build(BuildContext context) {

    return BlocProvider<ThemeBloc>(
      builder: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeData>(
        builder: (context, theme) {
          return MaterialApp(
            title: 'Z.金融理财',
            theme: theme,
            home: ManagerPage(),
            localizationsDelegates:  [ // 国际化代理
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('zh', 'CN'), // 中文简体
              // const Locale('en', 'US'), // 美国英语
            ],
            // routes: ZRouter.routerStore, //注册路由表
          );
        },
      ),
    );
  }
}
