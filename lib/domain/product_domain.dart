class Product {
  String id = '';
  String rate = '';
  String name = '';
  String rateTime = '';
  String desc = '';
  String limitDesc = '';

  Product();

  Product.fromJson(Map json) {
    this.id = json['id'];
    this.rate = json['rate'];
    this.name = json['pro'];
    this.rateTime = json['rateTime'];
    this.desc = json['desc'];
    this.limitDesc = json['limitDesc'];
  }
}