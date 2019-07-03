import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// Bloc注入
import 'package:flutter_app/unit/bloc_provider.dart';
// 页面
import 'package:flutter_app/page/payment/payment_page.dart';

import 'dart:async';
class CountBLoC {
  int _count;
  StreamController<int> _countController;

  CountBLoC() {
    _count = 0;
    _countController = StreamController<int>();
  }
  
  Stream<int> get value => _countController.stream;

  increment() {
    _countController.sink.add(++_count);
  }

  dispose() {
    _countController.close();
  }
}

class ProductDetailsPage extends StatelessWidget {

  final Map pro;
  ProductDetailsPage({@required this.pro});

  @override
  Widget build(BuildContext context) {

    // final bloc = BlocProvider.of(context);

    final bloc = new CountBLoC();

    return Scaffold(
      appBar: AppBar(
        title: Text('${pro['pro']}'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text('$pro'),
            StreamBuilder(
              stream: bloc.value,
              initialData: bloc.value,
              builder: (context, snapshot) {
                return Text(
                  'You hit me: ${snapshot.data} times',
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.navigate_next),
        onPressed: () =>
            Navigator.of(context).push(CupertinoPageRoute(builder: (context) => PaymentPage()))
          ),
    );
  }
}
