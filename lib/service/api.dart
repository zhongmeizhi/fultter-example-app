import 'package:zmz_app/service/service.dart';

class Api {

  // 获取用户信息
  static Function get getUserInfo => (phone) => service.fetch('/user-info?phone=$phone', isShowLoading: true);

  // 获取 热门推荐
  static Function get getChoiceList => () => service.fetch('/choice-list', isShowLoading: true);

  // 获取 银行精选
  static Function get getBankProductList => () => service.fetch('/bank_product_list', isShowLoading: true);

}