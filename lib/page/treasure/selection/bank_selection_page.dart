import 'package:zmz_app/compose/compose.dart';
import 'package:zmz_app/view/bank_product.dart';
// 请求
import 'package:zmz_app/service/api.dart';
// storage
import 'package:zmz_app/utils/storage.dart';
// 参数
import 'package:zmz_app/domain/route_argument.dart';

class BankSelectionPage extends StatefulWidget {
  final item;
  BankSelectionPage({Key key, this.item}) : super(key: key);

  @override
  _BankSelectionState createState() => _BankSelectionState();
  
}

class _BankSelectionState extends State<BankSelectionPage>
  with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;
  
  List _bankProductList = [];

  void getBankProduct() async {
    List data = await Api.getBankProductList();
    if (!mounted) return;
    setState(() {
      // Unhandled exception: setState() called after dispose()
      if (!mounted) {
        return;
      }
      _bankProductList = data;
    });
  }

  void _intoChoicenessDetail({id}) {
    bool isLogin = LocalStorage.getString('phone') == null;
    if (isLogin) {
      print('已登陆');
    } else {
      Navigator.pushNamed(context, "/login", arguments: RouteArguments<String>('想从银行精选登陆'));
    }
  }

  @override
  void initState() {
    getBankProduct();
    super.initState();
  }

  // 会提示 被 @mustCallSuper 重写后半年在调用这个重写方法
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      children: _itemsWidget(bankProductList: _bankProductList, intoChoicenessDetail: _intoChoicenessDetail),
    );
  }

}

// 如果在setSate时items不会重新渲染
// 可以看看Flutter的Diff算法。
List<Widget> _itemsWidget({@required bankProductList, @required intoChoicenessDetail}) {

  List<Widget> items = [];
  final int _len = bankProductList.length;

  for (int i = 0; i < _len; i++) {
    Map bank = bankProductList[i];
    List productList = bank['productList'];

    // 银行名称
    items.add(
      Padding(
        padding: EdgeInsets.only(left: ZFit().setWidth(20), top: ZFit().setWidth(10)),
        child: Text(
          bank['bankName'],
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: ZFit().setSp(18), fontWeight: FontWeight.w500),
        )
      )
    );

    // 银行产品添加
    for (int j = 0; j < productList.length; j++) {
      Map item = productList[j];
      items.add(
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ZFit().setWidth(20)
          ),
          child: BankProductWidget(item: item, intoChoicenessDetail: intoChoicenessDetail)
        )
      );
    }

    // 添加灰色横隔， 最底部不需要
    if ((i + 1) < _len) {
      items.add(
        Container(
          height: ZFit().setWidth(10),
          color: ZColor.thinGrey,
        )
      );
    }
  }

  // 最底部提示
  items.add(
    SizedBox(
      height: ZFit().setWidth(36),
      child: Text('已经到最底部啦...', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey))
    )
  );

  return items;

}