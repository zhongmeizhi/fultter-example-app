// page
import 'package:flutter/cupertino.dart';
import 'package:zmz_app/compose/compose.dart';
import 'package:zmz_app/page/login/login_page.dart';
import 'package:zmz_app/page/main_page.dart';

class RouterStore {

  static get login => LoginPage;
  static get mainpage => MainPage;

}

class ZRouter {

    static push(context, {@required Widget page}) {
      Navigator.push(context, CupertinoPageRoute(builder: (context) => page));
    }

    static pushAndRemoveUntil(context, {@required Widget page}) {
      Navigator.of(context).pushAndRemoveUntil(
          CupertinoPageRoute(builder: (context) => page), (route) => route == null);
    }

    // static pageContainer(widget) {
    //   return widget;
    // }
  
}