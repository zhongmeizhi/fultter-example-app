import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zmz_app/bloc/provider.dart'; // provider
import 'package:zmz_app/bloc/count_bloc.dart'; // Bloc注入
// 页面
import 'package:zmz_app/page/payment/payment_page.dart';
// 参数
import 'package:zmz_app/domain/route_argument.dart';

class ProductDetailsPage extends StatelessWidget {

  final Map pro;
  ProductDetailsPage({@required this.pro});

  @override
  Widget build(BuildContext context) {

    PaymentBloc bloc = BlocProvider.of<PaymentBloc>(context);

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
              initialData: bloc.money,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Column(
                  children: <Widget>[
                    ListTile(
                      leading: Text('支付方式'),
                      title: DropdownButton(
                        value: bloc.cardtype,
                        items: <DropdownMenuItem>[
                          DropdownMenuItem(
                            value: '1',
                            child: Text('招商银行'),
                          ),
                          DropdownMenuItem(
                            value: '2',
                            child: Text('农业银行'),
                          )
                        ],
                        onChanged: (val) {
                          bloc.changeCardtype(val.toString());
                        },
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: '购买金额'),
                          // TextSpan(text: '${snapshot.data}'),
                          TextSpan(text: '${bloc.money}'),
                          TextSpan(text: '元'),
                        ]
                      ),
                      style: TextStyle(fontSize: 26),
                    ),
                  ],
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
                arguments: RouteArguments('name', '蘑菇碳')
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
        onPressed: () => bloc.addMoney(),
      )
    );
  }
}
