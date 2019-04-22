
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BankProductWidget extends StatelessWidget {
  
  final item;
  final Function intoChoicenessDetail;

  BankProductWidget({@required this.item, this.intoChoicenessDetail});

  @override
  Widget build(BuildContext context) {

    // 判断是否有产品名称
    bool _containsProName = item.containsKey('pro');

    return Container(
      padding: EdgeInsets.only(top: ScreenUtil().setWidth(12), bottom: ScreenUtil().setWidth(12)),
      child: Column(
        children: <Widget>[
          // 如果有产品名称就展示
          _containsProName ? _proNameWidget(item['pro']) : Container(height: 0.0,),
          Row(
            children: <Widget>[
              Container(
                width: ScreenUtil().setWidth(100),
                alignment: Alignment.topLeft,
                child: Column(
                  children: <Widget>[
                    Text(
                      item['rate'],
                      style: TextStyle(fontSize: ScreenUtil().setSp(22), color: Colors.red)
                    ),
                    Text(
                      item['rateTime'],
                      style: TextStyle(fontSize: ScreenUtil().setSp(11), color: Color(0xFFB8B8B8))
                    )
                  ],
                ),
              ),
              Container(
                width:  ScreenUtil().setWidth(1),
                margin: EdgeInsets.only(right: ScreenUtil().setWidth(12)),
                height: ScreenUtil().setWidth(33),
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
                          style: TextStyle(fontSize: ScreenUtil().setSp(14))
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          item['limitDesc'],
                          style: TextStyle(fontSize: ScreenUtil().setSp(12), color: Color(0xFFB8B8B8))
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width:  ScreenUtil().setWidth(63),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.error, color: Colors.blue,),
                    Text('已售罄')
                  ],
                )
              ),
            ]
          ),
        ],
      )
    );
  }
}

Widget _proNameWidget (productName) {
  return Row(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(1)),
        child: Text(
          productName,
          style: TextStyle(fontSize: ScreenUtil().setSp(12), color: Color(0xFF666666))
        )
      )
    ]
  );
}
