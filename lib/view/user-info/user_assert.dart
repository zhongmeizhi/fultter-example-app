import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 用户资产
class UserAssertWidget extends StatelessWidget {

  final Map userInfo;
  final Function logout;
  UserAssertWidget({@required this.userInfo, @required this.logout});

  @override
  Widget build(BuildContext context) {
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
                child: Text(this.userInfo['name'], style: TextStyle(fontSize: ScreenUtil().setSp(16), color: Color(0xFF333333))),
              ),
              GestureDetector(
                child: Icon(
                  Icons.settings,
                  color: Color(0xFF333333),
                ),
                onTap: this.logout
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
                      child: Text(this.userInfo['money'], style: TextStyle(color: Colors.red, fontSize: ScreenUtil().setSp(16))),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              Text('累计收益'),
                              Text('+${this.userInfo["profit"]}元', style: TextStyle(color: Color(0xFFf7b6a9), fontSize: ScreenUtil().setSp(12)))
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
                              Text('${this.userInfo["midway"]}元', style: TextStyle(color: Color(0xFFf7b6a9), fontSize: ScreenUtil().setSp(12)))
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
}
Widget _userInfoUnitWidget ({@required icon, @required name}) {
    return Expanded(
      flex: 1,
      child: Container(
        alignment: Alignment.center,
        child: Text(name, style: TextStyle(color: Color(0xFF333333), fontSize: ScreenUtil().setSp(16))),
      )
    );
  }