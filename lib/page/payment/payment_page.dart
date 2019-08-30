import 'package:flutter/material.dart';
// 参数
// import 'package:zmz_app/domain/route_argument.dart';

class PaymentPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    // 接收RoutSetting的路由参数
    // RouteArguments args = ModalRoute.of(context).settings.arguments;

    // PaymentBloc bloc = BlocProvider.of<PaymentBloc>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('支付'),
      ),
      body: Container(
        // child: StreamBuilder(
        //   stream: bloc.countStream,
        //   initialData: bloc.money,
        //   builder: (BuildContext context, AsyncSnapshot snapshot) {
        //     return Container(
        //       child: Column(
        //         children: <Widget>[
        //           Text(args.title),
        //           Text(args.message),
        //           Text.rich(
        //             TextSpan(
        //               children: [
        //                 TextSpan(text: '需支付金额'),
        //                 // TextSpan(text: '${snapshot.data}'),
        //                 TextSpan(text: '${bloc.money}'),
        //                 TextSpan(text: '元'),
        //               ]
        //             ),
        //             style: TextStyle(fontSize: 26),
        //           )
        //         ],
        //       ),
        //     );
        //   },
        // )
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () => bloc.addMoney(),
      // ),
    );
  }
}