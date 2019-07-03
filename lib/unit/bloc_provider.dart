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

class CountBLoC {
  int _count;
  StreamController<int> _countController;

  CountBLoC() {
    _count = 0;
    _countController = StreamController<int>();
  }
  
  Stream<int> get value => _countController.stream;

  increment() {
    _countController.sink.add(++_count);
  }

  dispose() {
    _countController.close();
  }
}