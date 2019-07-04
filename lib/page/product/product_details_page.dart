import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// Bloc注入
import 'package:flutter_app/unit/bloc_provider.dart';
// 页面
import 'package:flutter_app/page/payment/payment_page.dart';

class ProductDetailsPage extends StatelessWidget {

  final Map pro;
  ProductDetailsPage({@required this.pro});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('产品详情'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('${pro['pro']}', style: TextStyle(fontSize: 26))
              ],
            ),
            Text('$pro'),
            StreamBuilder(
              stream: bloc.stream,
              initialData: bloc.value,
              builder: (context, snapshot) {
                return Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: '购买金额'),
                      TextSpan(text: '${snapshot.data}'),
                      TextSpan(text: '元'),
                    ]
                  ),
                  style: TextStyle(fontSize: 26),
                );
              },
            ),
            RaisedButton(
              child: Text('去支付'),
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(builder: (context) => PaymentPage())
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => bloc.increment(),
      )
    );
  }
}
