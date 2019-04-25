# 蘑菇碳的Flutter金融理财App

```
    RN是一种中间妥协方案，它会被浏览器技术的进步而取代，而Flutter是更加面向未来的一种彻底的跨平台渲染框架。

        by 闲鱼架构师：邬吉风
```

没错。用了Flutter就停不下来了。

> Example尽量多些常用的交互，少写些静态页面。

## 喜欢请Star，尽量别 Fork。

***

### 项目介绍

项目主要部分都有注释

> 开屏图使用`pushReplacementNamed`+`AnimationController`+`Timer`实现

![开屏](/preview/welcome.gif)

> 采用`IndexedStack`作为大框架，设置：按需加载和缓存。

![主架构](/preview/bottom_tab.gif)


> 登陆使用`SharedPreferences`(类似`LocalStorage`)实现长期登陆。

![登陆](/preview/login.gif)


> 轮播图使用`SingleTickerProviderStateMixin`的`Control`+`PageView`+`TabPageSelector`+`Timer`实现

![轮播图](/preview/carousel.gif)


> 新闻页使用`CustomScrollView`实现

![webview](/preview/custom_scroll.gif)


> 财富页仿蚂蚁财富定期理财，利用`TabBar`+`TabBarView`实现，同时使用`AutomaticKeepAliveClientMixin`重写`wantKeepAlive`

![财富页](/preview/top_bar.gif)


> WebView使用`flutter_webview_plugin`实现

![webview](/preview/webview.gif)


> 请求封装在`/lib/api/my_xhr.dart`

```
    _baseUrl ??= '';
    var responseBody;
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(_baseUrl + url));
    var response = await request.close();
    if (response.statusCode == 200) {
      // 序列化 response
      responseBody = await response.transform(utf8.decoder).join();
      responseBody = json.decode(responseBody);
    } else {
      print("error");
    }
    return responseBody['data'];
```

* 后台服务放置于`/back-end`目录，使用NodeJS搭建（单纯读JSON返回）
* 银行精选使用for循环各种拼装的方式实现渲染
* 屏幕适配使用了李卓原的适配方案，源码放置于`/lib/unit/screen_util_source.dart`
* 动态路由封装在`/lib/unit/route_animation.dart`
* EventBus使用FlutterChina的方式

### 项目计划
* [x] 静态页面
* [x] ScreenUtil 屏幕适配
* [x] 路由 + 回调 + 动画
* [x] 封装无限轮播图
* [x] EvnetBus
* [x] 封装httpClient请求
* [x] koa2 + node 后台服务器
* [x] 请求数据动态拼接
* [x] Storage 保持登录状态
* [x] 实现 webview
* [x] 缓存组件
* [x] 页面 keepa-live
* [x] 解决页面切换重绘问题
* [ ] Redux
* [ ] node架构完善
* [ ] RxDart

### 外链:
- [API文档](https://flutter.io/docs/get-started/codelab)
