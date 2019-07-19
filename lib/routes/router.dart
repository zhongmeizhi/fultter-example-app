// page
import 'package:zmz_app/page/main_page.dart';
import 'package:zmz_app/page/login/login_page.dart';

class Router {

  static final Object routes = {
      "/main_page": (context) => new MainPage(),
      "/login_page": (context) => new LoginPage(title: '登录')
    };
  
}