import 'package:zmz_app/compose/compose.dart';
// 页面
import 'package:zmz_app/page/treasure/selection/bank_selection_page.dart';
import 'package:zmz_app/page/treasure/selection/fund_selection_page.dart';
import 'package:zmz_app/page/treasure/selection/dealer_selection_page.dart';
import 'package:zmz_app/view/common/search_bar.dart';

class TreasurePage extends StatefulWidget {
  @override
  _TreasurePageState createState() => _TreasurePageState();
}

class _TreasurePageState extends State<TreasurePage>
  with SingleTickerProviderStateMixin {

  List tabs = [
    {
      'id': 't1',
      'label': '小书房'
    }, {
      'id': 't2',
      'label': '银行精选'
    }, {
      'id': 't3',
      'label': '券商'
    }, {
      'id': 't4',
      'label': '转让'
    }
  ];
  TabController _tabController;

  _pickTab (val) {
    print(val);
  }

  @override
  void initState() {
    super.initState();
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
      appBar: AppBar(
        automaticallyImplyLeading: false, // 防止自动出现返回键
        title: SearchBar(),
        bottom: TabBar(
          controller: _tabController,
          labelPadding: ZEdge.horizontal_5,
          isScrollable: true,
          tabs: tabs.map((tab) {
            return Container(
              width: ZFit().setWidth(90),
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
          switch (tab['id']) {
            case 't1':
              return FundSelectionPage();
            break;
            case 't2':
              return BankSelectionPage(item: tab);
            break;
            case 't3':
              return DealerSelectionPage();
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

