
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BankProduct extends StatelessWidget {
  
  final item;
  final Function intoChoicenessDetail;

  BankProduct({this.item, this.intoChoicenessDetail});

  @override
  Widget build(BuildContext context) {

    bool _containsProName = item.containsKey('pro');

    return Container(
      padding: EdgeInsets.only(top: ScreenUtil().setWidth(12), bottom: ScreenUtil().setWidth(12)),
      child: Column(
        children: <Widget>[
          _containsProName ? _proNameWidget(item['pro']) : Container(height: 0.0,),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    Text(
                      item['rate'],
                      style: TextStyle(fontSize: ScreenUtil().setSp(26), fontWeight: FontWeight.w700, color: Colors.red)
                    ),
                    Text(
                      item['rateTime'],
                      style: TextStyle(fontSize: ScreenUtil().setSp(11), color: Color(0xFFB8B8B8))
                    )
                  ],
                ),
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
                width: ScreenUtil().setWidth(66),
                height: ScreenUtil().setWidth(30),
                child: FlatButton(
                  color: Colors.white,
                  textColor: Colors.deepOrange,
                  splashColor: Colors.white,
                  highlightColor: Colors.white,
                  child: Text("存入"),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(style: BorderStyle.solid, color: Colors.deepOrange)
                  ),
                  onPressed: () => {
                    intoChoicenessDetail(id: item['id'])
                  }
                )
              )
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
        padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(9)),
        child: Text(
          productName,
          style: TextStyle(fontSize: ScreenUtil().setSp(14), color: Color(0xFF666666))
        )
      )
    ]
  );
}
