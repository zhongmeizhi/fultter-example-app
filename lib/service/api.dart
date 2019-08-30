import 'package:zmz_app/service/service.dart';
import 'package:zmz_app/config/base_info.dart';


class Api {

  var service;

  Api() {
    service = new Service(baseUrl: new Config().baseUrl);
  }

  // 获取用户信息
  Function get getUserInfo => (phone) => service.$get('/user-info?phone=$phone');

  // 获取 热门推荐
  Function get getChoiceList => () => service.$get('/choice-list');

  // 获取 银行精选
  Function get getBankProductList => () => service.$get('/bank_product_list');

}