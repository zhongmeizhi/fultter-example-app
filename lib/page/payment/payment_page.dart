import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zmz_app/bloc/payment/payment_bloc.dart';
import 'package:zmz_app/domain/route_argument.dart';
import 'package:zmz_app/routes/z_router.dart';
import 'package:zmz_app/styles/edge_style.dart';
import 'package:zmz_app/utils/event_bus.dart';
import 'package:zmz_app/utils/z_fit.dart';
// 参数

class PaymentPage extends StatefulWidget {

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

  @override
  Widget build(BuildContext context) {

    PaymentNumBloc _paymentNumBloc = BlocProvider.of<PaymentNumBloc>(context);

    return BlocBuilder<PaymentNumBloc, int>(
      builder: (context2, count) {
        return Container(
          padding: ZEdge.all_15,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('购买份数：${count.toString()}', style: TextStyle(fontSize: ZFit().setWidth(28),)),
              // Text('选择支付方式'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      _paymentNumBloc.dispatch(PaymentNumEvent.increment);
                    },
                    child: Text('再多买一份'),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login', arguments: RouteArguments('从购买页进入'));
                    },
                    child: Text('确认'),
                  ),
                ],
              )
            ],
          ),
        );
      }
    );
  }
}

