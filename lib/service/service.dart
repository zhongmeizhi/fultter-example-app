// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/cupertino.dart';

// class Service {
//   // 基础URL
//   String baseUrl;
//   Service({ @required this.baseUrl});
//   // get请求
//   $get(String url) async {
//     var responseBody;
//     var httpClient = new HttpClient();
//     var request = await httpClient.getUrl(Uri.parse(this.baseUrl + url));
//     var response = await request.close();
//     if (response.statusCode == 200) {
//       // 序列化 response
//       responseBody = await response.transform(utf8.decoder).join();
//       responseBody = json.decode(responseBody);
//     } else {
//       print("error");
//     }
//     return responseBody['data'];
//   }
//   // 其他请求类型待续
//   // 以后要加拦截器
//   // 异常捕获也需要完善
// }

import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:zmz_app/config/base_info.dart';
// import 'package:zmz_app/utils/event_bus.dart';

class _Service {

  _Service() {
    _initDio();
  }

  Dio _dio = new Dio();

  void _initDio () {
    _dio.interceptors.add(InterceptorsWrapper(
        onRequest:(RequestOptions options){
          // 在请求被发送之前做一些事情
          return options;
        },
        onResponse:(Response response) {
          // 在返回响应数据之前做一些预处理
          // TODO
          // eventBus.emit('fetchFailed');
          return response;
        },
        onError: (DioError error) {
          // 当请求失败时做一些预处理
          return error;
        }
    ));
  }

  Future fetch(url, {dynamic params, Map<String, dynamic> header, Options option, bool noTip = false}) async{

    Map<String, dynamic> headers = new HashMap();
    if (header != null) {
      headers.addAll(header);
    }

    if (option != null) {
      option.headers = headers;
    } else {
      option = new Options(method: "get");
      option.headers = headers;
    }

    try {
      Response _response = await _dio.request('${Config.baseUrl}$url', data: params, options: option);
      print(_response.data['result']);
      return _response.data['result'];
    } catch (error) {
      // ???
    }
  }

}

final _Service service = new _Service();