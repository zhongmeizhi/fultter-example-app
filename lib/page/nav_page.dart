
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zmz_app/bloc/theme_bloc.dart';
import 'package:zmz_app/compose/compose.dart';
// 页面
import 'package:zmz_app/page/home/home_page.dart';
import 'package:zmz_app/page/treasure/treasure_page.dart';
import 'package:zmz_app/page/customer/customer_page.dart';
import 'package:zmz_app/page/news/news_page.dart';
// 其他
import 'package:zmz_app/utils/update_app.dart'; // 更新App操作
import 'package:zmz_app/utils/center_nav.dart'; // BottomNav加号位置

class NavPage extends StatefulWidget {
  final String title;
  NavPage({Key key, this.title}) : super(key: key);

  @override
  _NavPageState createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {

  int _selectedIndex = 0;

  // 并不是 GlobalKey 类型
  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  PageController _pageController = new PageController();

  // bottomNavigationBar 点击事件
  void _tapBottomBar (index) {
    if (!mounted) return;
    setState(() { // 页面展示切换使用setState
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }
  
  void _checkAndUpate() {
    // 可以在第一次打开APP时执行"版本更新"的网络请求
    UpdateApp _updateApp = new UpdateApp();
    // context 能拿到
    _updateApp.checkAndUpate(context);
  }

  @override
  void initState() {
    super.initState();
    _checkAndUpate();
  }

  @override
  Widget build(BuildContext context) {

    final ThemeBloc themeBloc = BlocProvider.of<ThemeBloc>(context);

    return Scaffold(
      // key: _scaffoldKey,
      bottomNavigationBar: new BottomNavigationBar( // 底部导航
        type: BottomNavigationBarType.fixed, // 如果有4个bar那么必须要设置type
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
          const BottomNavigationBarItem(icon: Icon(Icons.payment), title: Text('财富')),
          const BottomNavigationBarItem(icon: Icon(null), title: Text('')), // 空BottomNav
          const BottomNavigationBarItem(icon: Icon(Icons.book), title: Text('资讯')),
          const BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('我的')),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.blue,
        onTap: _tapBottomBar,
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(), // 禁止页面滑动
        controller: _pageController,
        children: <Widget>[
          new HomePage(),
          TreasurePage(),
          Container(), // 空BottomNav对应页面
          NewsPage(),
          CustomerPage()
        ],
      ),
      floatingActionButton: Container(
        padding: ZEdge.all_5,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: ZColor.grey),
          borderRadius: BorderRadius.all(Radius.circular(ZFit().setWidth(55))),
          color: ZColor.defaultBackground
        ),
        child: FloatingActionButton(
          elevation: 0,
          backgroundColor: Colors.blue,
          child: Icon(Icons.autorenew, color: Colors.white,),
          onPressed: (){
            themeBloc.dispatch(ThemeEvent.toggle);
          },
        ),
      ),
      // const 很重要，不然每次点击BottomNav就会被重写一次
      floatingActionButtonLocation: const CenterNav()
    );
  }
  
}