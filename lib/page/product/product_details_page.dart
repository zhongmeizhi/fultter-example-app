import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// Bloc注入
import 'package:zmz_app/model/count_bloc.dart';
import 'package:zmz_app/model/provider.dart'; // Bloc注入
// 页面
import 'package:zmz_app/page/payment/payment_page.dart';
// 参数
import 'package:zmz_app/domain/page_argument.dart';

class ProductDetailsPage extends StatelessWidget {

  final Map pro;
  ProductDetailsPage({@required this.pro});

  @override
  Widget build(BuildContext context) {

    CounterBloc bloc = BlocProvider.of<CounterBloc>(context);

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
              stream: bloc.countStream,
              initialData: 0,
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
      bottomSheet: RawMaterialButton(
        fillColor: Colors.blue,
        onPressed: () {
          Navigator.of(context).push(
            // IOS的可侧滑回退路由
            CupertinoPageRoute(
              builder: (context) => PaymentPage(),
              settings: RouteSettings(
                arguments: StringArguments('name', '蘑菇碳')
              ),
            )
          );
        },
        child: Container(
          alignment: Alignment.bottomCenter,
          height: ScreenUtil().setWidth(47),
          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
          child: Text('去支付', style: TextStyle(color: Colors.white, fontSize: 22),),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => bloc.dispatch(),
      )
    );
  }
}
