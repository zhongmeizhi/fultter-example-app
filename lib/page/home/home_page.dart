import 'package:flutter/cupertino.dart';
import 'package:zmz_app/compose/compose.dart';
import 'package:zmz_app/domain/product_domain.dart';
import 'package:zmz_app/plugin/carousel.dart'; // 功能widget
import 'package:zmz_app/service/api.dart'; // 请求
import 'package:zmz_app/page/product/product_details_page.dart'; // 页面
import 'package:zmz_app/domain/route_argument.dart'; // 参数

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ScrollController _scrollController = ScrollController();
  List _choiceList = [];
    

  void getChoice() async {
    List data = await Api.getChoiceList();
    print(data);
    //如果当前控件已经被注销掉，则当前控件内置状态为mounted。
    if (!mounted) return;
    setState(() {
      _choiceList = data;
    });
  }

  // 下拉刷新方法
  Future<Null> _handleRefresh() async {
    await Future.delayed(Duration(seconds: 1), () { // Future.delayed（）方法可以选择延迟处理任务
      setState(() {
        getChoice();
        return null;
      });
    });
  }

  // 下拉加载
  void addListenerBottomUpdate() {
    _scrollController.addListener(() {
      // 判断是否到了最底部
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        setState(() {
          // 加载数据
          _choiceList.addAll(List.generate(2, (idx) {
            return {
                "id": "c",
                "rate": "3.45%",
                "name": "下拉加载",
                "rateTime": "业绩基准(年化)",
                "desc": "中低风险",
                "limitDesc": "锁定期"
            };
          }).toList());
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getChoice();
    addListenerBottomUpdate();
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
      body: RefreshIndicator( // 下拉刷新
        onRefresh: _handleRefresh,
        child: ListView(
          controller: _scrollController,
          children: <Widget>[
            _bannerWidget(),
            _displayDataWidget(), 
            _activityAdWidget(activityList: _activityList, context: context),
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
    carouselList: List<Widget>.generate(3, (idx) => 
      Image.asset('assets/images/banner_${idx + 1}.jpg', fit: BoxFit.fill)).toList(),
    tagWidth: ZFit().setWidth(375),
    height: ZFit().setWidth(146),
    tagBottom: ZFit().setWidth(8),
    tagColor: Colors.white12,
    activeTagColor: Colors.white,
    tagSize: ZFit().setWidth(10)
  );
}

Widget _displayDataWidget () {
  return Stack(
    children: <Widget>[
      ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: double.infinity,
          minHeight: ZFit().setWidth(36)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: ZEdge.horizontal_15,
              child: Icon(Icons.pie_chart, color: ZColor.thinBlue, size: ZFit().setWidth(19),),
            ),
            Padding(
              padding: EdgeInsets.only(right: ZFit().setWidth(13)),
              child: Text('理财成交单',
                style: TextStyle(fontWeight: FontWeight.w700, color: ZColor.black, fontSize: ZFit().setSp(14), height: 0.85),
              ), 
            ),
            Text('昨日成交163人，今日已成交57人',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: ZColor.thinBlue, fontSize: ZFit().setSp(11)),
            ),
          ],
        )
      ),
      Positioned(
        right: ZFit().setWidth(10),
        top: ZFit().setWidth(7),
        child: Icon(Icons.keyboard_arrow_right, color: ZColor.grey,)
      )
    ],
  );
}

Widget _activityAdWidget ({context, activityList}) {

  void _intoActivityDetail({id}) {
    print(id);
    Navigator.pushNamed(context, "/login_page", arguments: RouteArguments<String>('想从活动登陆'));
  }

  final List<Widget> items = [];
  for (int i = 0; i < activityList.length; i++) {
    Map item = activityList[i];
    items.add(Expanded(
      flex: 1,
      child: Padding(
        padding: ZEdge.all_15,
        child: GestureDetector(
          child: Row(
            children: <Widget>[
              new Icon(item['iconSrc'], color: Colors.blue,),
              Padding(
                padding: EdgeInsets.only(left: ZFit().setWidth(10)),
                child: Column(
                  children: <Widget>[
                    Text(item['title'], style: TextStyle(color: ZColor.black, fontSize: ZFit().setSp(15))),
                    Text(item['desc'], style: TextStyle(color: ZColor.grey, fontSize: ZFit().setSp(11)))
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

Widget _choicenessWidget ({context, List choiceList}) {

  void _intoChoicenessDetail({Product proInfo}) {
    // 调用IOS的右滑动回退功能
    Navigator.push(context, CupertinoPageRoute(builder: (context) {
      return ProductDetailsPage(pro: proInfo);
    }));
  }

  return Padding(
    padding: ZEdge.horizontal_15,
    child: Column(
      children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: double.infinity, //宽度尽可能大
            minHeight: ZFit().setWidth(18)
          ),
          child: Text(
            '热门推荐',
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: ZFit().setSp(18), fontWeight: FontWeight.w700, height: 1.5),
          ),
        ),
        // 使用Wrap的方式展示产品
        Wrap(
          children: choiceList.map((item) {
            Product _pro = Product.fromJson(item);
            return Container(
              width: ZFit().setWidth(160),
              margin: ZEdge.all_5,
              padding: ZEdge.vertical_10,
              decoration: BoxDecoration(
                border: Border.all(style: BorderStyle.solid, color: Colors.blue),
                borderRadius: ZRadius.all_8
              ),
              child: Column(
                children: <Widget>[
                  Text(_pro.name, style: TextStyle(fontSize: ZFit().setSp(16))),
                  Text(_pro.rate, style: TextStyle(fontSize: ZFit().setSp(26), fontWeight: FontWeight.w700, color: Colors.red)),
                  Text(_pro.rateTime, style: TextStyle(color: Colors.grey, fontSize: ZFit().setSp(12)),),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: ZFit().setWidth(6)),
                    padding: EdgeInsets.symmetric(horizontal: ZFit().setWidth(3)),
                    decoration: BoxDecoration(
                      border: Border.all(style: BorderStyle.solid, color: Colors.blue)
                    ),
                    child: Text(_pro.desc),
                  ),
                  Container(
                    width: ZFit().setWidth(110),
                    height: ZFit().setWidth(30),
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
                        _intoChoicenessDetail(proInfo: _pro)
                      }
                    )
                  )
                ],
              ),
            );
          }).toList(),
        ),
        SizedBox(
          height: ZFit().setWidth(36),
          child: Text('已经到最底部啦...', style: TextStyle(color: Colors.grey),)
        )
      ],
    )
  );
}