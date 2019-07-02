import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// 页面
import 'package:flutter_app/page/treasure/selection/bank_selection_page.dart';
import 'package:flutter_app/page/treasure/selection/fund_selection_page.dart';
import 'package:flutter_app/page/treasure/selection/dealer_selection_page.dart';

class TreasurePage extends StatefulWidget {
  @override
  _TreasurePageState createState() => _TreasurePageState();
}

class _TreasurePageState extends State<TreasurePage>
  with SingleTickerProviderStateMixin {

  List tabs = [
    {
      'id': 't1',
      'label': '银行精选'
    }, {
      'id': 't2',
      'label': '券商'
    }, {
      'id': 't3',
      'label': '基金'
    }, {
      'id': 't4',
      'label': '转让'
    }, {
      'id': 't5',
      'label': '预约投资'
    }, {
      'id': 't6',
      'label': '普惠'
    },
  ];
  TabController _tabController;

  _pickTab (val) {
    print(val);
  }

  @override
  void initState() {
    super.initState();
    // 创建Controller
    // 只有 with SingleTickerProviderStateMixin 后才有 TickerProvider，也就是 this
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  //  使用 TabBar + TabBarView
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      appBar: AppBar(
        title: Text('Z.财富'),
        bottom: TabBar(
          controller: _tabController,
          labelPadding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(2), vertical: 0),
          isScrollable: true,
          tabs: tabs.map((tab) {
            return Container(
              width: ScreenUtil().setWidth(90),
              child: Tab(text: tab['label']),
            );
          }).toList(),
          onTap: _pickTab,
        ),
        centerTitle: true, // appBar文字居中
      ),
      body:
       new TabBarView(
        key: new Key('treasure_page'),
        controller: _tabController,
        children: tabs.map((tab) {
          // 利用 PageStorageKey 保持页面滚动状态
          //     key: PageStorageKey(tab['id']),
          switch (tab['id']) {
            case 't1':
              return BankSelectionPage(item: tab);
            break;
            case 't2':
              return DealerSelectionPage();
            break;
            case 't3':
              return FundSelectionPage();
            break;
            default:
              return Center(
                child: Text('这里是 -> ' + tab['label']),   
              );
            break;
          }
        }).toList(),
      ),
    );
  }
}

