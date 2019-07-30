// import 'package:flutter/material.dart';
import 'package:zmz_app/model/provider.dart';
import 'dart:async';

// 简单的 Bloc
// 每次点击加一块钱

class CounterBloc extends BlocBase {
  int _count = 0;
  int get count => _count;

  // stream
  StreamController<int> _countController = StreamController.broadcast();

  Stream<int> get countStream => _countController.stream; // 用于 StreamBuilder 的 stream

  void dispatch() {
    _countController.sink.add(++_count); // 用于通知修改值
  }

  @override
  void dispose() {
    _countController.close(); // 注销资源
  }
}