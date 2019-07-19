import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// Bloc注入
import 'package:zmz_app/unit/bloc_provider.dart';
// 页面
import 'package:zmz_app/page/payment/payment_page.dart';

class ProductDetailsPage extends StatelessWidget {

  final Map pro;
  ProductDetailsPage({@required this.pro});

  @override
  Widget build(BuildContext context) {

    // var bloc = BlocProvider.of(context);

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
            
          ],
        ),
      ),
      bottomSheet: RaisedButton(
        color: Colors.blue,
        padding: EdgeInsets.fromLTRB(22, 6, 22, 6),
        onPressed: () {
          Navigator.of(context).push(
            CupertinoPageRoute(builder: (context) => PaymentPage())
          );
        },
        child: Container(
          alignment: Alignment.bottomCenter,
          height: ScreenUtil().setWidth(32),
          child: Text('去支付', style: TextStyle(color: Colors.white, fontSize: 22),),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => bloc.increment(),
      )
    );
  }
}
