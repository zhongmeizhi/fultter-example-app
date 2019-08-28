import 'package:zmz_app/compose/compose.dart';

// 用户产品清单
class ShopListWidget extends StatelessWidget {

  // String title;
  // String subtitle;
  // ShopListWidget({@required this.title, @required this.subtitle});

  Widget _shoppingUnitWidget ({@required title, @required subtitle}) {
    return Container(
      width: ZFit().setWidth(174),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Wrap(
          alignment: WrapAlignment.start,
          children: <Widget>[
            _shoppingUnitWidget(title: '零钱理财', subtitle: '53412.21元'),
            _shoppingUnitWidget(title: '期限理财', subtitle: '346342.21元'),
            _shoppingUnitWidget(title: '网贷', subtitle: '233523.21元'),
            _shoppingUnitWidget(title: '基金', subtitle: '5476.21元'),
            _shoppingUnitWidget(title: '养老', subtitle: '949764.21元'),
            _shoppingUnitWidget(title: '银行精选', subtitle: '23416.21元'),
            _shoppingUnitWidget(title: '私募', subtitle: '756423.21元'),
            _shoppingUnitWidget(title: '资产管理', subtitle: '645212.21元'),
          ],
        )
      ],
    );
  }
}