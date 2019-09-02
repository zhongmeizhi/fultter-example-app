import 'package:bloc/bloc.dart';

// decrement
enum PaymentNumEvent { increment, reset }


class PaymentNumBloc extends Bloc<PaymentNumEvent, int> {

  int _initNum = 1;

  @override
  int get initialState => _initNum;

  @override
  Stream<int> mapEventToState(PaymentNumEvent event) async* {
    switch (event) {
      case PaymentNumEvent.reset:
        yield _initNum;
        break;
      case PaymentNumEvent.increment:
        yield currentState + 1;
        break;
    }
  }
}