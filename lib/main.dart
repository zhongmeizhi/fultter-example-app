import 'package:flutter/material.dart';
import 'package:flutter_app/home/homepage.dart';
import 'package:flutter_app/treasure/treasurepage.dart';
import 'package:flutter_app/customer/customerpage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: MainPage(title: '金融理财'),
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
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[ //导航栏右侧菜单
          IconButton(icon: Icon(Icons.share), onPressed: () {}),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar( // 底部导航
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
          BottomNavigationBarItem(icon: Icon(Icons.payment), title: Text('财富')),
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('我的')),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.deepOrange,
        onTap: (index) {
          _selectedIndex = index;
          setState(() {
            print(_selectedIndex);
          });
        },
      ),
      body: new Center(
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

