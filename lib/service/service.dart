import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';

class Service {

  // 基础URL
  String baseUrl;
  Service({ @required this.baseUrl});

  // get请求
  $get(String url) async {
    var responseBody;
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(this.baseUrl + url));
    var response = await request.close();
    if (response.statusCode == 200) {
      // 序列化 response
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
