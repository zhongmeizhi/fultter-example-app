import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_app/view/bank_product.dart';
// 请求
import 'package:flutter_app/unit/my_xhr.dart';
class BankSelectionPage extends StatefulWidget {
  final item;
  BankSelectionPage({Key key, this.item}) : super(key: key);

  @override
  _BankSelectionState createState() => _BankSelectionState();
  
}

class _BankSelectionState extends State<BankSelectionPage> {
  
  List _bankProductList = [];

  void getBankProduct() async {
    List data = await MyXhr.$get('/bank_product_list');
    //如果当前控件已经被注销掉，则当前控件内置状态为mounted。
    if (!mounted) return;
    setState(() {
      _bankProductList = data;
    });
  }

  void _intoChoicenessDetail({id}) {
    print(id);
    Navigator.pushNamed(context, "/login_page");
  }

  @override
  void initState() {
    getBankProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return ListView(
      children: _itemsWidget(bankProductList: _bankProductList, intoChoicenessDetail: _intoChoicenessDetail),
    );
  }

}

// 通过请求获取数据，使用for循环List.add()动态拼接返回items。在setSate时items不会重新渲染
// 将拼接过程放到 class 外部。渲染正常
List<Widget> _itemsWidget({@required bankProductList, @required intoChoicenessDetail}) {

  List<Widget> items = [];
  final int _len = bankProductList.length;

  for (int i = 0; i < _len; i++) {
    Map bank = bankProductList[i];
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
          child: BankProductWidget(item: item, intoChoicenessDetail: intoChoicenessDetail)
        )
      );
    }

    // 添加灰色横隔， 最底部不需要
    if ((i + 1) < _len) {
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

  return items;

}