import 'package:flutter/material.dart';

// 统一路由动画效果
class MyRoute {
  
  // 缩放路由动画
  static Future scaleRoute (BuildContext context, Widget widget) {
    // 返回 Future
    return Navigator.push(context,
      // 启用动画路由，在回退时也有效
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 300), //动画时间为500毫秒
        pageBuilder: (context, animation, secondaryAnimation) {
            return new ScaleTransition( // 移动动画
              scale: animation,
              child: widget
            );
          }
      )
    );
  }

  // 其他路由操作见 https://github.com/zhongmeizhi/flutter-router
  
}