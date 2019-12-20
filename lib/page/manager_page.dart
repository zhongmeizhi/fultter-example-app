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
      Future.microtask(() => Toast.show(context, message));
    });

    eventBus.on('showLoading', (message) {
      Future.microtask(() => Loading.show(context, message));
    });

    eventBus.on('closeLoading', (message) {
      Future.microtask(() => Loading.close());
    });

    DateTime _lastPressedAt; //上次点击时间

    return WillPopScope( // 导航返回拦截
      onWillPop: () async {
        if (_lastPressedAt == null ||
            DateTime.now().difference(_lastPressedAt) > Duration(milliseconds: 500)) {
          //两次点击间隔超过1秒则重新计时
          _lastPressedAt = DateTime.now();

          // 点击手机的下发回退键盘，触发pop
          Navigator.maybePop(ZRouter.context);
          return false;
        }
        return true;
      },
      child: Navigator( // 实现SPA
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          // 路由表对应单页
          Widget _page = ZRouter.routerStore[settings.name];

          // Cupertino路由动画
          return CupertinoPageRoute(
            settings: settings, // 参数
            builder: (context) {
              // 每一个子页面的context
              ZRouter.context = context;
              return _page;
            }
          );
        }
      )
    );
  }
  
}

