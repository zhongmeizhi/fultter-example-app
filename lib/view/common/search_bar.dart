import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zmz_app/view/my_search.dart';

class SearchBar extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    var _searchValue = '';

    return Row(
      children: <Widget>[
        InputChip(
          backgroundColor: Colors.white,
          label: Container(
            alignment: Alignment.center,
            width: ScreenUtil().setWidth(250),
            height: ScreenUtil().setWidth(22),
            child: Text('搜索'),
          ),
          onPressed: () {
            showSearch(
              context: context,
              query: _searchValue,
              delegate: MySearch(_searchValue)
            );
          },
        ),
        Container(
          child: MaterialButton(
            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
            minWidth: ScreenUtil().setWidth(33),
            child: Text('提问', style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(16))),
            onPressed: () {
              Scaffold.of(context).showSnackBar(const SnackBar(
                content: Text("不给你提问."),
              ));
            }
          )
        )
      ],
    );
  }
}