import 'package:zmz_app/compose/compose.dart';
import 'package:zmz_app/utils/storage.dart'; // storage
import 'package:zmz_app/service/api.dart'; // 请求
import 'package:zmz_app/view/user-info/shop_list.dart';
import 'package:zmz_app/view/user-info/user_assert.dart';

class CustomerPage extends StatefulWidget {
  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {

  bool _isLogin = false;
  Map _userInfo;
  List _expandIndex = [false, false];

  // 获取用户数据
  Future _getUserInfo (phone) async {
    var data = await Api.getUserInfo(phone);
    return data;
  }

  // 检查登录
  void _checkoutLogin() {
    LocalStorage.getString('phone').then((phone) {
      if (phone != null) {
        // 获取后台数据
        _getUserInfo(phone).then((userInfo) {
          if (!mounted) return;
          setState(() {
            _isLogin = true;
            _userInfo = userInfo;
          });
        });
      }
    });
  }

  // 进入登录页
  void _loginAccount() {
    Navigator.pushNamed(context, '/login').then((res) {
      _checkoutLogin();
    });
  }

  // 退出登录
  void _logout() {
    LocalStorage.remove('phone').then((res) {
      if (!mounted) return;
      setState(() {
        _isLogin = false;
        _userInfo = null;
      });
    });
  }
  
  @override
  void initState() {
    super.initState();
    // 判断登录
    _checkoutLogin();
  }
  
  @override
  Widget build(BuildContext context) {

    List _account = [
      {
        'name': '一账通账户',
        'text': '未登录',
      }
    ];

    List<Widget> dispenseWidget() {
      if (_isLogin) {
        return [
          UserAssertWidget(userInfo: _userInfo, logout: _logout) ,
          _brWidget(), // 灰色间隔
          ShopListWidget(),
          _brWidget(), // 灰色间隔
          _contactWidget(),
          _brWidget(), // 灰色间隔
        ];
      } else {
        return  [
          _registeredWidget(context: context, loginAccount: _loginAccount),
          _brWidget(), // 灰色间隔
          _contactWidget(),
          _brWidget(), // 灰色间隔
        ];
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Z.我的'),
        centerTitle: true, // appBar文字居中
      ),
      endDrawer: Drawer(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              child: Image.asset('assets/images/logo.jpg'),
            ),
            Container(
              margin: ZEdge.horizontal_20,
              child: ExpansionPanelList(
                expansionCallback: (int panelIndex, bool isExpanded) {
                  setState(() {
                    _expandIndex[panelIndex] = !isExpanded;
                  });
                },
                children: _account.map((val) {
                  return ExpansionPanel(
                    isExpanded: _expandIndex[0],
                    headerBuilder: (BuildContext context, bool isExpanded){
                      return Container(
                        padding: ZEdge.all_15,
                        child: Text(val['name']),
                      );
                    },
                    body: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      padding: ZEdge.all_15,
                      color: ZColor.thinGrey,
                      child: Text(val['text']),
                    )
                  );
                }).toList()
              )
            )
          ],
        ),
      ),
      body: ListView(
        children: dispenseWidget(),
      ),
    );
  }
}

// 用户未登录模块
Widget _registeredWidget ({@required context, @required loginAccount}) {
  
  Widget _loginBannerWidget () {

    return GestureDetector(
      child: Stack(
        children: <Widget>[
          Container(
            width: ZFit().setWidth(360),
            height: ZFit().setWidth(160),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: ZRadius.all_5,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.pink,
                  ZColor.thinBlue
                ]
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: ZFit().setWidth(20)),
                  child: Text('互联网金融平台', style: TextStyle(color: Colors.white, fontSize: ZFit().setSp(12)))
                ),
                Padding(
                  padding: EdgeInsets.only(top: ZFit().setWidth(30)),
                  child: FlatButton(
                    disabledTextColor: Colors.blue,
                    disabledColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: ZFit().setWidth(38), vertical: ZFit().setWidth(5)),
                    shape: RoundedRectangleBorder(borderRadius: ZRadius.all_15),
                    child: Text("注册领红包", style: TextStyle(fontSize: ZFit().setSp(18), fontWeight: FontWeight.bold, color: Colors.white)),
                    onPressed: null
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(top: ZFit().setWidth(6)),
                  child: Text('立即登录 >', style: TextStyle(color: Colors.white, fontSize: ZFit().setSp(14)))
                )
              ],
            )
          ),
        ],
      ),
      onTap: loginAccount
    );
  }

  return Container(
    padding: ZEdge.horizontal_15,
    child: Column(
      children: <Widget>[
        Container(
          padding: ZEdge.vertical_10,
          width: ZFit().setWidth(375),
          child: Text('欢迎来到金融理财', style: TextStyle(fontSize: ZFit().setSp(16))),
        ),
        _loginBannerWidget()
      ],
    ),
  );
}


// 客服模块
Widget _contactWidget () {
  Widget _contactStyleWidget ({@required icon, @required text}) {
    return Container(
      child: Row(
        children: <Widget>[
          Padding(
            padding: ZEdge.horizontal_5,
            child:Icon(icon, color: ZColor.grey, size: ZFit().setSp(16)),
          ),
          Text(text, style: TextStyle(color: ZColor.grey, fontSize: ZFit().setSp(14)),)
        ]
      ),
    );
  }
  return Container(
    height: ZFit().setWidth(45),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _contactStyleWidget(icon: Icons.headset_mic, text: '在线客服'),
        _contactStyleWidget(icon: Icons.phone_iphone, text: '电话客服'),
      ],
    ),
  );
}

// 灰色间隔
Widget _brWidget ({height = 9}) {
  return Container(
    height: ZFit().setWidth(height),
    color: ZColor.thinGrey,
  );
}