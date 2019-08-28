
import 'package:zmz_app/compose/compose.dart';

class BankProductWidget extends StatelessWidget {
  
  final item;
  final Function intoChoicenessDetail;

  BankProductWidget({@required this.item, this.intoChoicenessDetail});

  @override
  Widget build(BuildContext context) {

    // 判断是否有产品名称
    bool _containsProName = item.containsKey('pro');

    return Container(
      padding: EdgeInsets.only(top: ZFit().setWidth(12), bottom: ZFit().setWidth(12)),
      child: Column(
        children: <Widget>[
          // 如果有产品名称就展示
          _containsProName ? _proNameWidget(item['pro']) : Container(height: 0.0,),
          GestureDetector(
            onTap: () {
              this.intoChoicenessDetail();
            },
            child: Row(
              children: <Widget>[
                Container(
                  width: ZFit().setWidth(100),
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: <Widget>[
                      Text(
                        item['rate'],
                        style: TextStyle(fontSize: ZFit().setSp(22), color: Colors.red)
                      ),
                      Text(
                        item['rateTime'],
                        style: TextStyle(fontSize: ZFit().setSp(11), color: Color(0xFFB8B8B8))
                      )
                    ],
                  ),
                ),
                Container(
                  width:  ZFit().setWidth(1),
                  margin: EdgeInsets.only(right: ZFit().setWidth(12)),
                  height: ZFit().setWidth(33),
                  color: Color(0xFFc3c3c3),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            item['desc'],
                            style: TextStyle(fontSize: ZFit().setSp(14))
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            item['limitDesc'],
                            style: TextStyle(fontSize: ZFit().setSp(12), color: Color(0xFFB8B8B8))
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  width:  ZFit().setWidth(63),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.error, color: Colors.blue,),
                      Text('已售罄')
                    ],
                  )
                ),
              ]
            ),
          )
        ],
      )
    );
  }
}

Widget _proNameWidget (productName) {
  return Row(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(bottom: ZFit().setWidth(1)),
        child: Text(
          productName,
          style: TextStyle(fontSize: ZFit().setSp(12), color: Color(0xFF666666))
        )
      )
    ]
  );
}
