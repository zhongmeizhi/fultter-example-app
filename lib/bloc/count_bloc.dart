// import 'package:zmz_app/bloc/provider.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:zmz_app/domain/payment_model.dart';


// class PaymentBloc extends BlocBase {
//   PaymentModel _paymentBloc = new PaymentModel.fromJson({
//     'money': 0,
//     'cardtype': '1'
//   });
  
//   int get money => _paymentBloc.money;
//   String get cardtype => _paymentBloc.cardtype;

//   /* 
//    * 单订阅 stream，整个生命周期只允许有一个监听
//    * 使用 broadcast 可以有多个监听
//    */
//   // StreamController<int> _countController = StreamController.broadcast();
//   // Stream<int> get countStream => _countController.stream; // 用于 StreamBuilder 的 stream

//   // 使用RXJS改写
//   BehaviorSubject<PaymentModel> _countController = BehaviorSubject();
//   Observable<PaymentModel> get countStream => Observable(_countController.stream);

//   void addMoney() {
//     // _countController.sink.add(_count); // 用于通知修改值
//     _paymentBloc.setMoney(money + 100);
//     _countController.add(_paymentBloc); // Subject可以直接用add添加
//   }

//   void changeCardtype(val) {
//     _paymentBloc.setCardType(val);
//     _countController.add(_paymentBloc);
//   }

//   @override
//   void dispose() {
//     _countController.close(); // 注销资源
//   }
// }