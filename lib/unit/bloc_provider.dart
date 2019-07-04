import 'package:flutter/material.dart';
import 'dart:async';

class BlocProvider extends InheritedWidget {

  final CountBLoC bLoC = CountBLoC();

  BlocProvider({
    @required bLoc,
    Key key,
    Widget child
  }) : super(key: key, child: child);

  // 更新自动通知
  @override
  bool updateShouldNotify(_) => true;

  static CountBLoC of(BuildContext context) =>
    (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider)
    .bLoC;
}

// 简单的 Bloc
class CountBLoC {
  int _count;
  var _countController;

  CountBLoC() {
    _count = 0;
    _countController = StreamController<int>.broadcast();
  }
  
  Stream<int> get stream => _countController.stream;
  int get value => _count;

  increment() {
    // xx
    _countController.sink.add(++_count);
  }

  dispose() {
    // 销毁时要关掉
    _countController.close();
  }
}

// 外部通过调用 bloc
CountBLoC bloc = CountBLoC();