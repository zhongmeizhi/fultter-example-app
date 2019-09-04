import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zmz_app/bloc/payment/payment_bloc.dart';
import 'package:zmz_app/compose/compose.dart';
import 'package:zmz_app/domain/product_domain.dart';
import 'package:zmz_app/page/payment/payment_page.dart'; // 页面

class ProductDetailsPage extends StatelessWidget {

  final Product pro;
  ProductDetailsPage({@required this.pro});

  @override
  Widget build(BuildContext context) {

    return BlocProvider<PaymentNumBloc>(
      builder: (context) => PaymentNumBloc(),
      child: BlocBuilder<PaymentNumBloc, int>(
        // bloc: PaymentNumBloc(), // 这样注入将限定为单个窗口小部件并且无法通过父窗口和BlocProvider当前窗口小部件访问的块
        builder: (context2, count) {

          // 灰常重要
          // 一定要在 BlocProvider后面
          PaymentNumBloc _paymentNumBloc = BlocProvider.of<PaymentNumBloc>(context2);

          return Scaffold(
            appBar: AppBar(
              title: Text('Z.产品详情'),
              elevation: 0,
            ),
            body: Stack(
              children: <Widget>[
                SafeArea(
                  child: ListView(
                    children: <Widget>[
                      Container(
                        padding: ZEdge.all_15,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[
                              Colors.blue,
                              ZColor.defaultBackground
                            ]
                          )
                        ),
                        child: Column(
                          children: <Widget>[
                            Text(this.pro.name, style: TextStyle(fontSize: ZFit().setWidth(14)),),
                            Container(
                              padding: ZEdge.vertical_5,
                              child: Text(this.pro.rate, style: TextStyle(fontSize: ZFit().setWidth(42), color: Colors.white),),
                            ),
                            Text(this.pro.rateTime, style: TextStyle(fontSize: ZFit().setWidth(16)),),
                          ],
                        ),
                      ),
                      Container(
                        padding: ZEdge.all_15,
                        child: _buyControl(count, _paymentNumBloc),
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: RaisedButton(
                    color: ZColor.thinBlue,
                    onPressed: (){
                      // 让push的 子Widget 同步Bloc
                      showModalBottomSheet(
                        context: context,
                        builder: (_) {
                          // 使用已经存在的 bloc value
                          return BlocProvider.value(
                            value: _paymentNumBloc,
                            child: PaymentPage()
                          );
                        }
                      );
                    },
                    child: Container(
                      padding: ZEdge.vertical_10,
                      alignment: Alignment.center,
                      width: ZFit().setWidth(375),
                      child: Text('确认购买', style: TextStyle(color: Colors.white, fontSize: ZFit().setWidth(16)),),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

Column _buyControl (count, _paymentNumBloc) {
  return Column(
    children: <Widget>[
      Container(
        padding: ZEdge.all_15,
        child: Row(
          children: <Widget>[
            Text('购买份数', style: TextStyle(fontSize: ZFit().setWidth(22)),),
            Container(
              padding: ZEdge.horizontal_15,
              child: Text('$count', style: TextStyle(fontSize: 24.0),),
            ),
          ],
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            child: FlatButton(
              shape: Border.all(width: 1, color: ZColor.grey),
              child: Text('重置', style: TextStyle(color: ZColor.black),),
              onPressed: () {
                _paymentNumBloc.dispatch(PaymentNumEvent.reset);
              },
            ),
          ),
          Container(
            child: FlatButton(
            color: ZColor.thinBlue,
              child: Text('添加', style: TextStyle(color: Colors.white),),
              onPressed: () {
                _paymentNumBloc.dispatch(PaymentNumEvent.increment);
              },
            ),
          ),
        ],
      )
    ]
  );
}