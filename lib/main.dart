import 'package:flutter/material.dart';
// 自己的文件包
import 'package:flutter_app/page/welcome/splash_page.dart';
import 'package:flutter_app/page/home/home_page.dart';
import 'package:flutter_app/page/treasure/treasure_page.dart';
import 'package:flutter_app/page/customer/customer_page.dart';
// 请求
import 'package:flutter_app/api/my_xhr.dart';
// 路由
import 'package:flutter_app/routes/router.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Z.金融理财',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),//注册路由表
      routes:Router.routes ,
      home: SplashScreen(),
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
// 所有无效

class _MainPageState extends State<MainPage> {


  int _selectedIndex;

  // 初始化 请求的baseURL
  void _setBaseUrl () {
    MyXhr myXhr = new MyXhr();
    myXhr.$option(baseUrl: 'http://10.93.157.10:2333');
  }

  @override
  void initState() {
    _setBaseUrl();
    _selectedIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar( // 底部导航
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
          BottomNavigationBarItem(icon: Icon(Icons.payment), title: Text('财富')),
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('我的')),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.deepOrange,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: new Container(
        key: PageStorageKey(1),
        child: _distributeHome(),
      ),
    );
  }

  // 分发Home页面路由
  Widget _distributeHome () {
    switch(_selectedIndex) {
      case 0:
        return new HomePage();
        break;
      case 1:
        return new TreasurePage();
      break;
      case 2:
        return new CustomerPage();
      break;
      default:
        return HomePage();
      break;
    }
  }
}

