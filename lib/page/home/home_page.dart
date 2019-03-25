import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    List _activityList = [
      {
        'iconSrc': 'assets/images/gift.png',
        'title': '挖宝加息',
        'desc': '挖宝享每日加息'
      }, {
        'iconSrc': 'assets/images/invite.png',
        'title': '邀请奖励',
        'desc': '每邀1人奖80元'
      }
    ];

    List _choiceList = [
      {
        'rate': '4.32%',
        'pro': '招招利',
        'rateTime': '七日年化收益率', 
        'desc': '灵活存取',
        'limitDesc': '10元起投'
      }, {
        'rate': '4.21%',
        'pro': '农加利',
        'rateTime': '七日年化收益率', 
        'desc': '28天',
        'limitDesc': '锁定期'
      }, {
        'rate': '5.55%',
        'pro': '宇宙行理财',
        'rateTime': '七日年化收益率', 
        'desc': '180天可自动转让',
        'limitDesc': '锁定期1天'
      }, {
        'rate': '4.72%',
        'pro': '招行理财',
        'rateTime': '七日年化收益率', 
        'desc': '灵活存取',
        'limitDesc': '1000元起投'
      }, 
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        // shrinkWrap: true,
        children: <Widget>[
          _bannerWidget(),
          _displayDataWidget(), 
          _activityAdWidget(_activityList),
          _subscribedWidget(),
          _choicenessWidget(_choiceList, context)
        ],
      )
    );
  }
}

Widget _bannerWidget () {
  return new Image.asset('assets/images/banner360.jpg', width: ScreenUtil().setWidth(375), height: ScreenUtil().setWidth(146));
}

Widget _displayDataWidget () {
  return Stack(
    children: <Widget>[
      ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: double.infinity,
          minHeight: ScreenUtil().setWidth(36)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(14), right: ScreenUtil().setWidth(5)),
              child: Icon(Icons.pie_chart, color: Color(0xFF5ca0fd), size: ScreenUtil().setWidth(19),),
            ),
            Padding(
              padding: EdgeInsets.only(right: ScreenUtil().setWidth(13)),
              child: Text(
                '平台交易数据',
                style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF333333), fontSize: ScreenUtil().setSp(14), height: 0.85),
              ), 
            ),
            Text(
              '昨日成交3人，今日已成交0人',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Color(0xFF5ca0fd), fontSize: ScreenUtil().setSp(11)),
            ),
          ],
        )
      ),
      Positioned(
        right: ScreenUtil().setWidth(10),
        top: ScreenUtil().setWidth(7),
        child: Icon(Icons.keyboard_arrow_right, color: Color(0xFFA1ADBB),)
      )
    ],
  );
}

Widget _activityAdWidget (List _activityList) {

  final List<Widget> items = [];
  for (int i = 0; i < _activityList.length; i++) {
    Map item = _activityList[i];
    items.add(Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.all(ScreenUtil().setWidth(18)),
        child: Row(
          children: <Widget>[
            new Image.asset(item['iconSrc'], width: ScreenUtil().setWidth(40), height: ScreenUtil().setWidth(40)),
            Padding(
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
              child: Column(
                children: <Widget>[
                  Text(item['title'], style: TextStyle(color: Color(0xFF333333), fontSize: ScreenUtil().setSp(15))),
                  Text(item['desc'], style: TextStyle(color: Color(0xFFB8B8B8), fontSize: ScreenUtil().setSp(11)))
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  return Flex(
    direction: Axis.horizontal,
    children: items,
  );
}

Widget _subscribedWidget () {
  return DecoratedBox(
    decoration: BoxDecoration(
      color: Color(0xFFF6F6F6)
    ),
    child: Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setWidth(10), bottom: ScreenUtil().setWidth(10)),
      child: Image.asset('assets/images/subscribed.jpg', width: ScreenUtil().setWidth(375)),
    )
  );
}

Widget _choicenessWidget (List _choiceList, context) {

  final List<Widget> items = [];
  for (int i = 0; i < _choiceList.length; i++) {
    Map item = _choiceList[i];
    items.add(
      SizedBox(
        height: ScreenUtil().setWidth(102),
        child: Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setWidth(12), bottom: ScreenUtil().setWidth(12)),
          child: Column(
            children: <Widget>[Row(
                  children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(9)),
                    child: Text(
                      item['pro'],
                      style: TextStyle(fontSize: ScreenUtil().setSp(14), color: Color(0xFF666666))
                    )
                  )
                ]
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        Text(
                          item['rate'],
                          style: TextStyle(fontSize: ScreenUtil().setSp(26), fontWeight: FontWeight.w700, color: Colors.red)
                        ),
                        Text(
                          item['rateTime'],
                          style: TextStyle(fontSize: ScreenUtil().setSp(11), color: Color(0xFFB8B8B8))
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              item['desc'],
                              style: TextStyle(fontSize: ScreenUtil().setSp(14))
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              item['limitDesc'],
                              style: TextStyle(fontSize: ScreenUtil().setSp(12), color: Color(0xFFB8B8B8))
                            )
                          ],
                        )
                      ],
                    ),
                  ), 
                  Container(
                    width: ScreenUtil().setWidth(66),
                    height: ScreenUtil().setWidth(30),
                    child: FlatButton(
                      color: Colors.white,
                      textColor: Colors.deepOrange,
                      splashColor: Colors.white,
                      highlightColor: Colors.white,
                      child: Text("存入"),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(style: BorderStyle.solid, color: Colors.deepOrange)
                      ),
                      onPressed: () => {
                        Navigator.pushNamed(context, "login_page")
                      },
                    ),
                  )
                ]
              ),
            ],
          )
        )
      )
    );
  }

  return Padding(
    padding:EdgeInsets.only(left: ScreenUtil().setWidth(15), right: ScreenUtil().setWidth(15)),
    child: Column(
      children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: double.infinity, //宽度尽可能大
            minHeight: ScreenUtil().setWidth(18)
          ),
          child: Text(
            '精选推荐',
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: ScreenUtil().setSp(18), fontWeight: FontWeight.w700, height: 1.5),
          ),
        ),
        Column(children: items),
        SizedBox(
          child: Text('已经到最底部啦...')
        )
      ],
    )
  );
}