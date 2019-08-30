import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:zmz_app/bloc/main_bloc.dart';
import 'package:zmz_app/bloc/payment/payment_bloc.dart';
import 'package:zmz_app/bloc/theme_bloc.dart';
import 'package:zmz_app/compose/compose.dart';
// import 'package:zmz_app/bloc/provider.dart'; // provider
// import 'package:zmz_app/bloc/count_bloc.dart'; // Bloc注入
// 页面
// import 'package:zmz_app/page/payment/payment_page.dart';
// 参数
// import 'package:zmz_app/domain/route_argument.dart';

class ProductDetailsPage extends StatelessWidget {

  final Map pro;
  ProductDetailsPage({@required this.pro});

  @override
  Widget build(BuildContext context) {

    return BlocProvider<CounterBloc>(
      builder: (context) => CounterBloc(),
      child: BlocBuilder<CounterBloc, int>(
        builder: (context, count) {

          // 一定要在 BlocProvider后面
          final counterBloc = BlocProvider.of<CounterBloc>(context);

          return Scaffold(
            appBar: AppBar(title: Text('Z.产品详情')),
            body: Center(
              child: Text(
                '$count',
                style: TextStyle(fontSize: 24.0),
              ),
            ),
            floatingActionButton:  Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () {
                    counterBloc.dispatch(CounterEvent.increment);
                  },
                ),
                FloatingActionButton(
                  child: Icon(Icons.brush),
                  onPressed: () {
                    counterBloc.dispatch(CounterEvent.decrement);
                  },
                ),
              ]
            )
          );
        },
      ),
    );
  }
}
