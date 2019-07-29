import 'package:flutter/material.dart';

class Toast {

  static OverlayEntry _overlayEntry; // toast靠它加到屏幕上
  static bool _showing = false; // toast是否正在showing
  static DateTime _startedTime; // 开启一个新toast的当前时间，用于对比是否已经展示了足够时间
  static String _msg;

  static void show(
    BuildContext context,
    String msg,
  ) async {

    assert(msg != null);
    _msg = msg;

    if(_msg == null || _msg.length < 1){
      _msg = '处理中';
    }
    _startedTime = DateTime.now();
    _showing = true;

    //获取OverlayState
    OverlayState overlayState = Overlay.of(context);
    if (_overlayEntry == null) {

      // 没有Overlay 那么造一个
      _overlayEntry = OverlayEntry(
        builder: (BuildContext context) => Center(
          // 动画效果
          child: AnimatedOpacity(
            opacity: _showing ? 1.0 : 0.0, //目标透明度
            duration: _showing ? Duration(milliseconds: 100) : Duration(milliseconds: 400),
            child: Card(
              color: Colors.black26,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: Text(_msg, style: TextStyle(fontSize: 14.0, color: Colors.white ),
                ),
              ),
            ),
          )
        )
      );
      
      // 将Overlay塞到State中
      overlayState.insert(_overlayEntry);

    } else {

      // 重新绘制UI，类似setState
      _overlayEntry.markNeedsBuild();

    }

    await Future.delayed(Duration(milliseconds: 2000)); //等待两秒
    // new Future.delayed(Duration(seconds: 2)).then((value) {
    //   _overlayEntry.remove();
    // });
    
    // 2秒后 到底消失不消失
    if (DateTime.now().difference(_startedTime).inMilliseconds >= 2000) {

      _showing = false;
      // 移除Overlay
      _overlayEntry.remove();
      _overlayEntry = null;

    }

  }

}