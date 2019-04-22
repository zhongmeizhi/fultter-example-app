import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_app/unit/event_bus.dart';
import 'package:flutter_app/storage/storage.dart'; // storage
import 'package:flutter_app/api/my_xhr.dart'; // 请求
import 'package:flutter_app/unit/route_animation.dart'; // 路由动画
// 页面
import 'package:flutter_app/page/login/login_page.dart';

class CustomerPage extends StatefulWidget {
  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {

  final EventBus bus = new EventBus();

  bool _isLogin = false;
  Map _userInfo;

  // 获取用户数据
  Future _getUserInfo (phone) async {
    var data = await MyXhr.$get('/user-info?phone=$phone');
    return data;
  }

  // 检查登录
  void _checkoutLogin() {
    LocalStorage.getString('phone').then((phone) {
      if (phone != null) {
        // 获取后台数据
        _getUserInfo(phone).then((userInfo) {
          // Unhandled exception: setState() called after dispose()
          if (!mounted) {
            return;
          }
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
    MyRoute.scaleRoute(context, LoginPage()).then((res) {
      _checkoutLogin();
    });
  }

  // 退出登录
  void _logout() {
    LocalStorage.remove('phone').then((res) {
      // Unhandled exception: setState() called after dispose()
      if (!mounted) {
        return;
      }
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
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      appBar: AppBar(
        title: Text('Z.我的'),
      ),
      body: ListView(
        children: <Widget>[
          _isLogin ? _accountWidget(userInfo: _userInfo, logout: _logout) : _registeredWidget(context: context, loginAccount: _loginAccount),
          _brWidget(),
          _shoppingListWidget(),
          _brWidget(),
          _contactWidget(),
          _brWidget()
        ],
      ),
    );
  }
}

// 用户模块
Widget _accountWidget ({@required userInfo, @required logout}) {

  Widget _userInfoUnitWidget ({@required icon, @required name}) {
    return Expanded(
      flex: 1,
      child: Container(
        alignment: Alignment.center,
        child: Text(name, style: TextStyle(color: Color(0xFF333333), fontSize: ScreenUtil().setSp(16))),
      )
    );
  }

  return Container(
    padding: EdgeInsets.symmetric(
      horizontal:  ScreenUtil().setWidth(20),
      vertical: ScreenUtil().setWidth(12)
    ),
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Text(userInfo['name'], style: TextStyle(fontSize: ScreenUtil().setSp(16), color: Color(0xFF333333))),
            ),
            GestureDetector(
              child: Icon(
                Icons.settings,
                color: Color(0xFF333333),
              ),
              onTap: logout
            )
          ],
        ),
        Stack(
          children: <Widget>[
            Positioned(
              child: Container(
                width: ScreenUtil().setWidth(335),
                height: ScreenUtil().setWidth(123),
                margin: EdgeInsets.all(ScreenUtil().setWidth(6)),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.all(Radius.circular(12))
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: ScreenUtil().setWidth(18), bottom: ScreenUtil().setWidth(10)),
                    child: Text('总资产(元)')
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(8)),
                    child: Text(userInfo['money'], style: TextStyle(color: Colors.red, fontSize: ScreenUtil().setSp(16))),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            Text('累计收益'),
                            Text('+${userInfo["profit"]}元', style: TextStyle(color: Color(0xFFf7b6a9), fontSize: ScreenUtil().setSp(12)))
                          ],
                        ),
                      ),
                      Container(
                        width: ScreenUtil().setWidth(1),
                        height: ScreenUtil().setWidth(22),
                        color: Color(0xFFc3c3c3),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            Text('在途'),
                            Text('${userInfo["midway"]}元', style: TextStyle(color: Color(0xFFf7b6a9), fontSize: ScreenUtil().setSp(12)))
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setWidth(10)),
          child: Row(
            children: <Widget>[
              _userInfoUnitWidget(icon: Icons.view_compact, name: '取现'),
              _userInfoUnitWidget(icon: Icons.pages, name: '充值')
            ],
          )
        )
      ],
    ),
  );
}

// 用户未登录模块
Widget _registeredWidget ({@required context, @required loginAccount}) {
  
  Widget _loginBannerWidget () {

    return GestureDetector(
      child: Stack(
        children: <Widget>[
          Image.asset('assets/images/red_envelope.jpg', width: ScreenUtil().setWidth(360), height: ScreenUtil().setWidth(160), fit: BoxFit.fill,),
          Align(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: ScreenUtil().setWidth(20)),
                  child: Text('互联网金融平台', style: TextStyle(color: Color(0xfef3ca80), fontSize: ScreenUtil().setSp(12)))
                ),
                Padding(
                  padding: EdgeInsets.only(top: ScreenUtil().setWidth(40)),
                  child: FlatButton(
                    disabledTextColor: Colors.blue,
                    disabledColor: Colors.blue,
                    padding:EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(38), vertical: ScreenUtil().setWidth(5)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ScreenUtil().setWidth(22))),
                    child: Text("注册领红包", style: TextStyle(fontSize: ScreenUtil().setSp(18), fontWeight: FontWeight.bold, color: Colors.white)),
                    onPressed: null
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(top: ScreenUtil().setWidth(6)),
                  child: Text('立即登录 >', style: TextStyle(color: Color(0xFFFEF3CA), fontSize: ScreenUtil().setSp(13)))
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
    padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(13)),
    child: Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(8)),
          width: ScreenUtil().setWidth(375),
          child: Text('欢迎来到金融理财', style: TextStyle(fontSize: ScreenUtil().setSp(16))),
        ),
        _loginBannerWidget()
      ],
    ),
  );
}

// 用户产品清单
Widget _shoppingListWidget () {

  Widget _shoppingUnitWidget ({@required title, @required subtitle}) {
    return Container(
      width: ScreenUtil().setWidth(174),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }

  return Column(
    children: <Widget>[
      Wrap(
        alignment: WrapAlignment.start,
        children: <Widget>[
          _shoppingUnitWidget(title: '零钱理财', subtitle: '53412.21元'),
          _shoppingUnitWidget(title: '期限理财', subtitle: '346342.21元'),
          _shoppingUnitWidget(title: '网贷', subtitle: '233523.21元'),
          _shoppingUnitWidget(title: '基金', subtitle: '5476.21元'),
          _shoppingUnitWidget(title: '养老', subtitle: '949764.21元'),
          _shoppingUnitWidget(title: '银行精选', subtitle: '23416.21元'),
          _shoppingUnitWidget(title: '私募', subtitle: '756423.21元'),
          _shoppingUnitWidget(title: '资产管理', subtitle: '645212.21元'),
        ],
      )
    ],
  );
}

// 客服模块
Widget _contactWidget () {
  Widget _contactStyleWidget ({@required icon, @required text}) {
    return Expanded(
      flex: 1,
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: ScreenUtil().setWidth(3)),
            child:Icon(icon, color: Color(0xFF8B8B8B), size: ScreenUtil().setSp(16)),
          ),
          Text(text, style: TextStyle(color: Color(0xFF8B8B8B), fontSize: ScreenUtil().setSp(14)),)
        ]
      ),
    );
  }
  return Container(
    padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(55)),
    height: ScreenUtil().setWidth(45),
    child: Row(
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
    height: ScreenUtil().setWidth(height),
    color: Color(0xFFf6f6f6),
  );
}