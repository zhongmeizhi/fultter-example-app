import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_app/unit/event_bus.dart';

class CustomerPage extends StatefulWidget {
  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {

  final EventBus bus = new EventBus();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      appBar: AppBar(
        title: Text('Z.我的'),
      ),
      body: ListView(
        children: <Widget>[
          _accountWidget(context: context),
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

Widget _accountWidget ({@required context}) {
  
  Widget _loginBannerWidget () {
    void _loginAccount() {
      Navigator.pushNamed(context, "login_page");
    }
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
      onTap: _loginAccount
    );
  }

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
    padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(13)),
    child: Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(8)),
          width: ScreenUtil().setWidth(375),
          child: Text('欢迎来到金融理财', style: TextStyle(fontSize: ScreenUtil().setSp(16))),
        ),
        _loginBannerWidget(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(14), horizontal: ScreenUtil().setWidth(10)),
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

Widget _brWidget ({height = 9}) {
  return Container(
    height: ScreenUtil().setWidth(height),
    color: Color(0xFFf6f6f6),
  );
}