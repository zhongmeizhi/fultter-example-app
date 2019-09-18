
import 'package:zmz_app/compose/compose.dart';
import 'package:zmz_app/domain/route_argument.dart';
import 'package:zmz_app/page/login/login_page.dart';
import 'package:zmz_app/page/nav_page.dart';
import 'package:zmz_app/page/product/product_details_page.dart';
import 'package:zmz_app/page/welcome/splash_page.dart';

class ZRouter {

  // SPA 路由表
  static Map<String, Widget> get routerStore => {
    '/': SplashPage(),
    '/main_page': NavPage(),
    '/login': LoginPage(),
    '/product_detail': ProductDetailsPage()
  };

  
  /*
    获取页面参数
    @context
    @defaultData
   */
  static T getPageArguments<T>(context, defaultData) {
    RouteArguments<T> _args = ModalRoute.of(context).settings.arguments ?? RouteArguments<T>(defaultData);
    return _args.args;
  }

}