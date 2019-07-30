import 'package:zmz_app/service/service.dart';
import 'package:zmz_app/config/base_info.dart';


class Api {

  var service;

  Api() {
    service = new Service(baseUrl: new Config().baseUrl);
  }

  // 获取用户信息
  get getUserInfo => (phone) => service.$get('/user-info?phone=$phone');

  // 获取 热门推荐
  get getChoiceList => () => service.$get('/choice-list');

  // 获取 银行精选
  get getBankProductList => () => service.$get('/bank_product_list');

}