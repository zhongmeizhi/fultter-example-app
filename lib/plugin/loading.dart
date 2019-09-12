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

    assert(msg != null);
    _msg = msg;
    if(_msg == null || _msg.length < 1){
      _msg = '处理中';
    }

    //获取OverlayState
    OverlayState overlayState = Overlay.of(context);
    if (_overlayEntry == null) {
      // 没有Overlay 那么造一个
      _overlayEntry = OverlayEntry(
        builder: (BuildContext context) => Material(
          color: ZColor.grey.withAlpha(123),
          child: Center(
            child: Container(
              width: ZFit().setWidth(133),
              height: ZFit().setWidth(133),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: ZRadius.all_5
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Text(_msg)
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