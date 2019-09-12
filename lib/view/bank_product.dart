
import 'package:zmz_app/compose/compose.dart';

class BankProductWidget extends StatelessWidget {
  
  final item;
  final Function intoChoicenessDetail;

  BankProductWidget({@required this.item, this.intoChoicenessDetail});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: ZEdge.vertical_8,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              this.intoChoicenessDetail();
            },
            child: Row(
              children: <Widget>[
                Container(
                  width: ZFit().setWidth(120),
                  alignment: Alignment.topLeft,
                  padding: ZEdge.horizontal_10,
                  decoration: BoxDecoration(
                    border: Border(right: BorderSide(width: 1, color: ZColor.grey))
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(item['rate'],
                        style: TextStyle(fontSize: ZFit().setSp(26), color: Colors.red)
                      ),
                      Text(item['rateTime'],
                        style: TextStyle(fontSize: ZFit().setSp(11), color: ZColor.black)
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ListTile(
                    title: Text(item['desc'],
                      style: TextStyle(fontSize: ZFit().setSp(14))
                    ),
                    subtitle: Text(item['limitDesc'],
                      style: TextStyle(fontSize: ZFit().setSp(12), color: ZColor.grey)
                    ),
                    trailing: Container(
                      width:  ZFit().setWidth(63),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.error, color: Colors.blue,),
                          Text('已售罄')
                        ],
                      )
                    ),
                  ),
                )
              ]
            ),
          )
        ],
      )
    );
  }
}
