import 'package:zmz_app/model/provider.dart';
// import 'dart:async';
import 'package:rxdart/rxdart.dart';

// 简单的 Bloc
// 每次点击加一块钱

class CounterBloc extends BlocBase {
  // int _count = 0;
  // int get count => _count;
  Map _paymentBloc = {
    'count': 0,
    'paymentMethod': '1'
  };
  
  int get count => _paymentBloc['count'];
  String get paymentMethod => _paymentBloc['paymentMethod'];

  /* 
   * 单订阅 stream，整个生命周期只允许有一个监听
   * 使用 broadcast 可以有多个监听
   */
  // StreamController<int> _countController = StreamController.broadcast();
  // Stream<int> get countStream => _countController.stream; // 用于 StreamBuilder 的 stream

  // 使用RXJS改写
  BehaviorSubject<Map> _countController = BehaviorSubject();
  Observable<Map> get countStream => Observable(_countController.stream);

  void countAdd() {
    _paymentBloc['count'] += 100;
    // _countController.sink.add(_count); // 用于通知修改值
    _countController.add(_paymentBloc); // Subject可以直接用add添加
  }

  void changePaymentMethod(val) {
    _paymentBloc['paymentMethod'] = val;
    _countController.add(_paymentBloc);
  }

  @override
  void dispose() {
    _countController.close(); // 注销资源
  }
}