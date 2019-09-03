import 'package:flutter/material.dart';
import 'package:zmz_app/styles/edge_style.dart';
import 'package:zmz_app/utils/z_fit.dart';
// 参数

class PaymentPage extends StatefulWidget {

  final int curNum;
  PaymentPage({curNum}) : curNum = curNum;

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: ZEdge.all_15,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('购买份数：${widget.curNum}', style: TextStyle(fontSize: ZFit().setWidth(28),)),
            Text('选择支付方式'),
          ],
        ),
      )
    );
  }
}

