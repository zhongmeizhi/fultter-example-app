import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zmz_app/bloc/payment/payment_bloc.dart';
// 参数

class PaymentPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final PaymentNumBloc _paymentNumBloc = BlocProvider.of<PaymentNumBloc>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('支付'),
      ),
      body: SafeArea(
        child: BlocBuilder<PaymentNumBloc, int>(
          builder: (context, count) {
            return Text(count.toString());
          }
        ),
      ),
    );
  }
}