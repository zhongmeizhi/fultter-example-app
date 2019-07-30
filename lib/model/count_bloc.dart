import 'package:zmz_app/model/provider.dart';
// import 'dart:async';
import 'package:rxdart/rxdart.dart';

// 简单的 Bloc
// 每次点击加一块钱

class CounterBloc extends BlocBase {
  int _count = 0;
  int get count => _count;

  /* 
   * 如果有多个监听，不使用 broadcast 会报错
   */
  // StreamController<int> _countController = StreamController.broadcast();
  BehaviorSubject<int> _countController = BehaviorSubject();

  Stream<int> get countStream => _countController.stream; // 用于 StreamBuilder 的 stream

  void dispatch() {
    ++_count;
    _countController.sink.add(_count); // 用于通知修改值
  }

  @override
  void dispose() {
    _countController.close(); // 注销资源
  }
}