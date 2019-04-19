import 'dart:convert';
import 'dart:io';

// 模拟器的浏览器中输入127.0.0.1所代表的是Android模拟器

class MyXhr {

  static String _baseUrl = '';

  //私有构造函数
  MyXhr._internal();
  //保存单例
  static MyXhr _singleton = new MyXhr._internal();
  //工厂构造函数
  factory MyXhr() => _singleton;

  // 配置
  void $option({String baseUrl = ''}) {
    _baseUrl = baseUrl;
  }

  // get请求
  static $get(String url) async {
    _baseUrl ??= '';
    var responseBody;
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(_baseUrl + url));
    var response = await request.close();
    if (response.statusCode == 200) {
      responseBody = await response.transform(utf8.decoder).join();
      responseBody = json.decode(responseBody);
    } else {
      print("error");
    }
    return responseBody['data'];
  }

  // 其他请求类型待续

  // 以后要加拦截器

  // 异常捕获也需要完善

}
