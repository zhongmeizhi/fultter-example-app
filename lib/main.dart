import 'package:flutter/material.dart';
// 页面
import 'package:flutter_app/page/welcome/splash_page.dart';
import 'package:flutter_app/page/home/home_page.dart';
import 'package:flutter_app/page/treasure/treasure_page.dart';
import 'package:flutter_app/page/customer/customer_page.dart';
import 'package:flutter_app/page/news/news_page.dart';
// 请求
import 'package:flutter_app/api/my_xhr.dart';
// 路由
import 'package:flutter_app/routes/router.dart';
// App升级
import 'package:flutter_downloader/flutter_downloader.dart';
// 使用 MethodChannel
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Z.金融理财',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false, // 不显示Debug图标
      routes:Router.routes , //注册路由表
      home: new SplashScreen(),
    );
  }
}

class MainPage extends StatefulWidget {
  final String title;
  MainPage({Key key, this.title}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

// 可以 with
// AutomaticKeepAliveClientMixin
// 然后重写 wantKeepAlive
// @override
// bool get wantKeepAlive => true;
// 但是：
// body中并没有使用PageView或TabBarView
// wantKeepAlive会无效果
class _MainPageState extends State<MainPage> {

  int _selectedIndex = 0;

  // 暂时先利用 cache 处理 IndexedStack 页面全部初始化问题
  List _indexedStackCache = <int>[0];

  // 初始化 请求的baseURL
  void _setBaseUrl () {
    MyXhr myXhr = new MyXhr();
    myXhr.$option(baseUrl: 'http://10.93.157.7:2333');
  }

  // bottomNavigationBar 点击事件
  void _tapBottomBar (index) {
    // Unhandled exception: setState() called after dispose()
    if (!mounted) {
      // 这算Flutter的BUG吧
      // 每次都有手动弄，又不值得封装
      return;
    }
    setState(() {
      _selectedIndex = index;
      if (_indexedStackCache.indexOf(index) == -1) {
        _indexedStackCache.add(index);
      }
    });
  }

  // 检查版本是否过低
  bool isVersionLower (String version) {
    // List _versionUtilList = version.split('.');
    return true;
  }

  // 获取安装地址
  Future<Map> getApkLocalInfo() async {
    // 不发请求了。直接硬编码
    final directory = {
      'version': '1.0.1',
      'url': 'xxx'
    };
    return directory;
  }

  // 下载
  Future<void> executeDownload(_appPath) async {
    //下载
    final taskId = await FlutterDownloader.enqueue(
        url: _appPath + '/app-release.apk',
        savedDir: _appPath,
        showNotification: true,
        openFileFromNotification: true);
    FlutterDownloader.registerCallback((id, status, progress) {
      // 当下载完成时，调用安装
      if (taskId == id && status == DownloadTaskStatus.complete) {
        installApk(_appPath);
      }
    });
  }

  // 安装
  Future<Null> installApk(_appPath) async {
    // 本地资源访问
    // flutter_app为项目名
    const platform = const MethodChannel('flutter_app');
    try {
      // 调用app地址
      await platform.invokeMethod('install', {'path': _appPath + '/app-release.apk'});
    } on PlatformException catch (_) {}
  }

  @override
  void initState() {
    super.initState();
    
    // 设置基础URL信息
    _setBaseUrl();

    // 可以在第一次打开APP时执行"版本更新"的网络请求
    getApkLocalInfo().then((directory) {
      String _version = directory['version'];
      // 比较服务器的版本号跟当前的版本号，来判断要不要升级APP应用程序
      if (isVersionLower(_version)) {
        String _appPath = directory['url'];

        // T O D O 应该是弹出dalog询问是否升级
        // 下载新版本
        executeDownload(_appPath);
      }
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: new BottomNavigationBar( // 底部导航
        type: BottomNavigationBarType.fixed, // 如果有4个bar那么必须要设置type，可能是BUG
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
          new BottomNavigationBarItem(icon: Icon(Icons.payment), title: Text('财富')),
          new BottomNavigationBarItem(icon: Icon(Icons.book), title: Text('新闻')),
          new BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('我的')),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.blue,
        onTap: _tapBottomBar,
      ),
      // IndexedStack 显示第index个child，其它child在页面上是不可见的
      // 但是 每个人page会在IndexedStack初始化的时候都会调用接口
      body: new IndexedStack(
        index: _selectedIndex,
        // child: _distributeHome(),
        children: <Widget>[
          new HomePage(),
          // 暂时先利用 cache 处理 IndexedStack 页面全部初始化问题
          (_indexedStackCache.indexOf(1) != -1) ? new TreasurePage() : Container(),
          (_indexedStackCache.indexOf(2) != -1) ? new NewsPage() : Container(),
          (_indexedStackCache.indexOf(3) != -1) ? new CustomerPage() : Container(),
        ],
      ),
    );
  }

  // 分发Home页面路由
  // 这种方式保持状态能力有限
  // 使用 IndexedStack 代替
  // Widget _distributeHome () {
  //   switch(_selectedIndex) {
  //     case 0:
  //       return new HomePage();
  //       break;
  //     case 1:
  //       return new TreasurePage();
  //     break;
  //     case 2:
  //       return new CustomerPage();
  //     break;
  //     default:
  //       return HomePage();
  //     break;
  //   }
  // }
}

