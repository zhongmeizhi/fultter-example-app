import 'package:flutter/material.dart';
// 功能widget
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_app/widget/carousel.dart';
// 请求
import 'package:flutter_app/api/my_xhr.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List _choiceList = [];

  void getChoice() async {
    List data = await MyXhr.$get('/choice-list');
    //如果当前控件已经被注销掉，则当前控件内置状态为mounted。
    if (!mounted) return;
    setState(() {
      _choiceList = data;
    });
  }

  // 下拉刷新方法
  Future<Null> _handleRefresh() async {
    await Future.delayed(Duration(seconds: 1), () { //Future.delayed（）方法可以选择延迟处理任务
      setState(() {
        print('开始刷新数据');
        getChoice();
        // onrefresh要返回future； child：必须为scrollable
        return null;
      });
    });
  }

  @override
  void initState() {
    getChoice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    List _activityList = [
      {
        'id': 'a1',
        'iconSrc': Icons.access_time,
        'title': '加息奖励',
        'desc': '挖宝享每日加息'
      }, {
        'id': 'a2',
        'iconSrc': Icons.person_add,
        'title': '邀请奖励',
        'desc': '每邀1人奖80元'
      }
    ];
    

    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator( // 下拉刷新
        onRefresh: _handleRefresh,
        child: ListView(
          children: <Widget>[
            _bannerWidget(),
            _displayDataWidget(), 
            _activityAdWidget(activityList: _activityList, context: context),
            _subscribedWidget(context: context),
            _choicenessWidget(choiceList: _choiceList, context: context)
          ],
        )
      )
    );
  }
}

Widget _bannerWidget () {
  // 轮播
  return Carousel(
    carouselList: <Widget>[
      new Image.asset('assets/images/banner_1.jpg', fit: BoxFit.fill),
      new Image.asset('assets/images/banner_2.jpg', fit: BoxFit.fill),
      new Image.asset('assets/images/banner_3.jpg', fit: BoxFit.fill)
    ],
    tagWidth: ScreenUtil().setWidth(375),
    height: ScreenUtil().setWidth(146),
    tagBottom: ScreenUtil().setWidth(8),
    tagColor: Color(0xffff33),
    activeTagColor: Colors.white,
    tagSize: ScreenUtil().setWidth(8)
  );
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
              child: Text('理财成交单',
                style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF333333), fontSize: ScreenUtil().setSp(14), height: 0.85),
              ), 
            ),
            Text('昨日成交163人，今日已成交57人',
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

Widget _activityAdWidget ({context, activityList}) {

  void _intoActivityDetail({id}) {
    print(id);
    Navigator.pushNamed(context, "/login_page");
  }

  final List<Widget> items = [];
  for (int i = 0; i < activityList.length; i++) {
    Map item = activityList[i];
    items.add(Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.all(ScreenUtil().setWidth(18)),
        child: GestureDetector(
          child: Row(
            children: <Widget>[
              new Icon(item['iconSrc'], color: Colors.blue,),
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
          onTap: () => {
            _intoActivityDetail(id: item['id'])
          }
        )
      ),
    ));
  }

  return Flex(
    direction: Axis.horizontal,
    children: items,
  );
}

Widget _subscribedWidget ({context}) {

  void _clickSubscribed () {
    Navigator.pushNamed(context, "/login_page");
  }

  return GestureDetector(
    child: DecoratedBox(
        decoration: BoxDecoration(
            color: Color(0xFFF6F6F6)
        ),
        child: Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setWidth(10), bottom: ScreenUtil().setWidth(10)),
          child: Image.asset('assets/images/subscribed.jpg', width: ScreenUtil().setWidth(375)),
        )
    ),
    onTap: _clickSubscribed,
  );
}

Widget _choicenessWidget ({context, List choiceList}) {

  void _intoChoicenessDetail({id}) {
    print(id);
    Navigator.pushNamed(context, "/login_page");
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
            '热门推荐',
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: ScreenUtil().setSp(18), fontWeight: FontWeight.w700, height: 1.5),
          ),
        ),
        // 使用Wrap的方式展示产品
        Wrap(
          children: choiceList.map((item) {
            return Container(
              width: ScreenUtil().setWidth(160),
              margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(6), vertical: ScreenUtil().setWidth(8)),
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(8)),
              decoration: BoxDecoration(
                border: Border.all(style: BorderStyle.solid, color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(8)))
              ),
              child: Column(
                children: <Widget>[
                  Text(item['pro'], style: TextStyle(fontSize: ScreenUtil().setSp(16))),
                  Text(item['rate'], style: TextStyle(fontSize: ScreenUtil().setSp(26), fontWeight: FontWeight.w700, color: Colors.red)),
                  Text(item['rateTime'], style: TextStyle(color: Colors.grey, fontSize: ScreenUtil().setSp(12)),),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(6)),
                    padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(3)),
                    decoration: BoxDecoration(
                      border: Border.all(style: BorderStyle.solid, color: Colors.blue)
                    ),
                    child: Text(item['desc']),
                  ),
                  Container(
                    width: ScreenUtil().setWidth(110),
                    height: ScreenUtil().setWidth(30),
                    child: FlatButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      splashColor: Colors.white,
                      highlightColor: Colors.white,
                      child: Text("存入"),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(style: BorderStyle.solid, color: Colors.blue)
                      ),
                      onPressed: () => {
                        _intoChoicenessDetail(id: item['id'])
                      }
                    )
                  )
                ],
              ),
            );
          }).toList(),
        ),
        SizedBox(
          height: ScreenUtil().setWidth(36),
          child: Text('已经到最底部啦...', style: TextStyle(color: Colors.grey),)
        )
      ],
    )
  );
}