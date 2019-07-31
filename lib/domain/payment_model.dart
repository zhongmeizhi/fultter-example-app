
class PaymentModel {

  int _money;
  String _cardtype;

  PaymentModel.fromJson(Map<String, dynamic> parsedJson) {
    _money = parsedJson['money'];
    _cardtype = parsedJson['cardtype'];
  }

  int get money => _money;
  String get cardtype => _cardtype;

  setMoney(val) {
    _money = val;
  }

  setCardType(val) {
    _cardtype = val;
  }

}