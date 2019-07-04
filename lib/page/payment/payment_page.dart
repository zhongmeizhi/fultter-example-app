import 'package:flutter/material.dart';
// Bloc注入
import 'package:flutter_app/unit/bloc_provider.dart';

class PaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // var bloc = BlocProvider.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('支付'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            StreamBuilder(
              stream: bloc.stream,
              initialData: bloc.value,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                return Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: '需支付金额'),
                      TextSpan(text: '${snapshot.data}'),
                      TextSpan(text: '元'),
                    ]
                  ),
                  style: TextStyle(fontSize: 26),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => bloc.increment(),
      ),
    );
  }
}