import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_app/view/bank_product.dart';

class BankSelectionPage extends StatefulWidget {
  final item;
  BankSelectionPage({Key key, this.item}) : super(key: key);

  @override
  _BankSelectionState createState() => _BankSelectionState();
  
}

class _BankSelectionState extends State<BankSelectionPage> {

  List _choiceList = [
    {
      'bankName': '鸭梨理财',
      'productList': [
        {
          'id': 'c8',
          'rate': '4.32%',
          'rateTime': '综合利率',
          'desc': '银行直供',
          'limitDesc': '0元起投'
        }
      ]
    }, {
      'bankName': '小招银行',
      'productList': [
        {
          'id': 'c1',
          'rate': '4.32%',
          'rateTime': '七日年化收益率',
          'desc': '灵活存取',
          'limitDesc': '10元起投'
        }, {
          'id': 'c6',
          'rate': '4.11%',
          'rateTime': '七日年化收益率',
          'desc': '30天可自动转让',
          'limitDesc': '锁定期1天'
        }, {
          'id': 'c4',
          'rate': '4.72%',
          'rateTime': '七日年化收益率',
          'desc': '灵活存取',
          'limitDesc': '1000元起投'
        }
      ]
    }, {
      'bankName': '宇宙银行',
      'productList': [
        {
          'id': 'c3',
          'rate': '5.55%',
          'rateTime': '七日年化收益率',
          'desc': '180天可自动转让',
          'limitDesc': '锁定期1天'
        }, {
          'id': 'c5',
          'rate': '5.12%',
          'rateTime': '七日年化收益率',
          'desc': '360天可自动转让',
          'limitDesc': '锁定期1天'
        }
      ]
    }
  ];

  final List<Widget> items = [];

  void _intoChoicenessDetail({id}) {
    print(id);
    Navigator.pushNamed(context, "login_page");
  }

  @override
  Widget build(BuildContext context) {

    for (int i = 0; i < _choiceList.length; i++) {
      Map bank = _choiceList[i];
      List productList = bank['productList'];

      // 银行名称
      items.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20), vertical: ScreenUtil().setWidth(5)),
          child: Text(
            bank['bankName'],
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: ScreenUtil().setSp(16), fontWeight: FontWeight.w500),
          )
        )
      );

      // 银行产品添加
      for (int j = 0; j < productList.length; j++) {
        Map item = productList[j];
        items.add(
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(20)
            ),
            child: new BankProductWidget(item: item, intoChoicenessDetail: _intoChoicenessDetail)
          )
        );
      }

      // 添加灰色横隔， 最底部不需要
      if ((i + 1) < _choiceList.length) {
        items.add(
          Container(
            height: ScreenUtil().setHeight(10),
            color: Color(0xFFf6f6f6),
          )
        );
      }
    }

    // 最底部提示
    items.add(
      SizedBox(
        height: ScreenUtil().setWidth(36),
        child: Text('已经到最底部啦...', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey))
      )
    );
    
    return ListView(
      children: items,
    );
  }

}