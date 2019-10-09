import 'package:flutter/cupertino.dart';
import 'package:zmz_app/compose/compose.dart';
import 'package:zmz_app/plugin/loading.dart';
import 'package:zmz_app/plugin/toast.dart';
import 'package:zmz_app/routes/z_router.dart';
import 'package:zmz_app/utils/event_bus.dart';

@ZMeta('管理页面')
class ManagerPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    // 初始化页面 width=375; height=812;
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

    return Navigator( // 实现SPA
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {

        // 路由表对应单页
        Widget _page = ZRouter.routerStore[settings.name];

        // 参数
        // settings.arguments

        // Cupertino路由动画
        return CupertinoPageRoute(
          settings: settings,
          builder: (context) => _page
        );
        
        // 自定义路由动画
        // PageRouteBuilder(
        //   settings: settings, // 传递页面参数
        //   pageBuilder:  (BuildContext nContext,Animation<double> animation, Animation<double> secondaryAnimation) => ScaleTransition(
        //     scale: animation,
        //     child: _page
        //   ),
        // );
      }
    );
  }
  
}