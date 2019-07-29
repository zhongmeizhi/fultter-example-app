// import 'package:flutter/material.dart';
import 'dart:async';

// class BlocProvider extends InheritedWidget {
//   final CountBLoC bLoC = CountBLoC();

//   BlocProvider({Key key, Widget child}) : super(key: key, child: child);

//   @override
//   bool updateShouldNotify(_) => true;

//   static CountBLoC of(BuildContext context) =>
//       (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider).bLoC;
// }

// 简单的 Bloc
class CountBLoC {
  int _count;
  var _countController;

  CountBLoC() {
    //  control要用broadcast，否则会报重复监听的异常
    _countController = StreamController<int>.broadcast();
    _count = 0;
  }
  
  // 外部get
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