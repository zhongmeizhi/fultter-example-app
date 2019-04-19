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
      child: Row(
        children: <Widget>[
          Icon(icon, color: Color(0xFFdca671)),
          Padding(
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(9)),
            child: Text(name, style: TextStyle(color: Color(0xFF333333), fontSize: ScreenUtil().setSp(16))),
          )
        ],
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
              child: Image.asset('assets/images/nicaifu.jpg', width: ScreenUtil().setWidth(335)),
            ),
            Positioned(
              left: ScreenUtil().setWidth(9),
              bottom: ScreenUtil().setWidth(7),
              child: Container(
                width: ScreenUtil().setWidth(317),
                height: ScreenUtil().setWidth(32),
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
                decoration: BoxDecoration(
                  color: Color(0xffe65134),
                  border: Border.all(color: Colors.transparent, width: 1.0),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(ScreenUtil().setWidth(12)),
                    bottomRight: Radius.circular(ScreenUtil().setWidth(12))
                  )
                ),
                child: Text(
                  '在途：${userInfo["midway"]}元',
                  style: TextStyle(
                      color: Color(0xFFf7b6a9),
                      fontSize: ScreenUtil().setSp(12),
                      height: 1.5
                    ),
                  ),
              )
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: ScreenUtil().setWidth(18), bottom: ScreenUtil().setWidth(20)),
                    child: Text('总资产(元)', style: TextStyle(color: Color(0xFFf7b6a9), fontSize: ScreenUtil().setSp(12)))
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(userInfo['money'], style: TextStyle(color: Color(0xFFf2b6ac), fontSize: ScreenUtil().setSp(34))),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: ScreenUtil().setWidth(6), bottom: ScreenUtil().setWidth(16)),
                    child: Text('累计总收益(元) ${userInfo["profit"]}', style: TextStyle(color: Color(0xFFf7b6a9), fontSize: ScreenUtil().setSp(12))),
                  ),
                ],
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setWidth(10)),
          child: Row(
            children: <Widget>[
              _userInfoUnitWidget(icon: Icons.view_compact, name: '卡券中心'),
              _userInfoUnitWidget(icon: Icons.pages, name: '会员中心')
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
          Image.asset('assets/images/red_envelope.jpg', width: ScreenUtil().setWidth(360)),
          Align(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: ScreenUtil().setWidth(20)),
                  child: Text('金服旗下互联网金融平台', style: TextStyle(color: Color(0xfef3ca80), fontSize: ScreenUtil().setSp(12)))
                ),
                Padding(
                  padding: EdgeInsets.only(top: ScreenUtil().setWidth(40)),
                  child: FlatButton(
                    disabledTextColor: Color(0xff704C18),
                    disabledColor: Color(0xfff5e3b2),
                    padding:EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(38), vertical: ScreenUtil().setWidth(5)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ScreenUtil().setWidth(22))),
                    child: Text("注册领500元红包", style: TextStyle(fontSize: ScreenUtil().setSp(18), fontWeight: FontWeight.bold)),
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
      Container(
        width: ScreenUtil().setWidth(350),
        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
        child: Stack(
          children: <Widget>[
            Text('我的账户', style: TextStyle(fontSize: ScreenUtil().setSp(16))),
            Positioned(
              right: ScreenUtil().setWidth(12),
              child: Text('提现', style: TextStyle(color: Color(0xFF8B8B8B), fontSize: ScreenUtil().setSp(12))),
            )
          ],
        ),
      ),
      Wrap(
        alignment: WrapAlignment.start,
        children: <Widget>[
          _shoppingUnitWidget(title: '货基', subtitle: '货基享受4.72%收益'),
          _shoppingUnitWidget(title: '随心宝', subtitle: '省心投资 灵活转让'),
          _shoppingUnitWidget(title: '安心计划', subtitle: '期限灵活 提前可转'),
          _shoppingUnitWidget(title: '智投宝', subtitle: '自动投标 智能匹配'),
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