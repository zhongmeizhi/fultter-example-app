import 'package:flutter/material.dart';
// 自己的文件包
import 'package:flutter_app/page/welcome/splash_page.dart';
import 'package:flutter_app/page/home/home_page.dart';
import 'package:flutter_app/page/treasure/treasure_page.dart';
import 'package:flutter_app/page/customer/customer_page.dart';
import 'package:flutter_app/page/login/login_page.dart';
// 请求
import 'package:flutter_app/unit/my_xhr.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),//注册路由表
    routes:{
      "MainPage": (context) => new MainPage(),
      "login_page": (context) => new LoginPage(title: '登录'),
    } ,
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

class _MainPageState extends State<MainPage> {
  int _selectedIndex;

  // 初始化 请求的baseURL
  void _setBaseUrl () {
    MyXhr myXhr = new MyXhr();
    myXhr.$option(baseUrl: 'http://127.0.0.1:2333');
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
        child: _distributeHome(),
      ),
    );
  }
  
  Widget _distributeHome () { // 分发Home页面路由
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

