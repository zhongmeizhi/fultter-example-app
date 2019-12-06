import 'package:flutter/material.dart';
import 'package:zmz_app/compose/compose.dart';
import 'package:zmz_app/utils/z_fit.dart';

class Loading {

  static OverlayEntry _overlayEntry; // 靠它加到屏幕上
  static String _msg;

  static void show(
    BuildContext context,
    String msg,
  ) async {

    _msg = msg;
    if(_msg == null || _msg.length < 1){
      _msg = '处理中...';
    }

    //获取OverlayState
    OverlayState overlayState = Overlay.of(context);
    if (_overlayEntry == null) {
      // 没有Overlay 那么造一个
      _overlayEntry = OverlayEntry(
        builder: (BuildContext context) => Material(
          color: ZColor.grey.withAlpha(23),
          child: Center(
            child: Container(
              width: ZFit().setWidth(123),
              height: ZFit().setWidth(123),
              padding: ZEdge.all_10,
              decoration: BoxDecoration(
                color: Color(0xff565656),
                boxShadow: <BoxShadow>[
                  BoxShadow(color: ZColor.grey, blurRadius: ZFit().setWidth(2))
                ],
                borderRadius: ZRadius.all_8
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    padding: ZEdge.all_15,
                    width: ZFit().setWidth(66),
                    height: ZFit().setWidth(66),
                    child: CircularProgressIndicator(
                      strokeWidth: 3.0
                    ),
                  ),
                  Text(_msg, style: TextStyle(color: Colors.white, fontSize: ZFit().setSp(16))),
                ],
              ),
            ),
          ),
        )
      );
      
      // 将Overlay塞到State中
      overlayState.insert(_overlayEntry);
    } else {
      // 重新绘制UI，类似setState
      _overlayEntry.markNeedsBuild();
    }

  }

  static void close() {
    try {
        // 移除Overlay
        _overlayEntry.remove();
        _overlayEntry = null;
      } catch (e) {
      }
  }

}