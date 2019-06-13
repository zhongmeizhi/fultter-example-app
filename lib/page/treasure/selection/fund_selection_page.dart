import 'package:flutter/material.dart';
import 'package:flutter_app/view/my_search.dart';

class FundSelectionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FundState();
}

class FundState extends State<FundSelectionPage> {

  var _searchValue;

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Container(
        height: 333,
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('进入 -> 我的搜索', style: TextStyle(fontSize: 22.0)),
              onPressed: () {
                showSearch(
                  context: context,
                  query: _searchValue,
                  delegate: MySearch(_searchValue)
                );
              },
            ),
            FlatButton(
              child: Text('进入 -> 百度搜索 WebView', style: TextStyle(fontSize: 22.0),),
              textColor: Colors.amber.withAlpha(222),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () {
                Navigator.pushNamed(context, '/baidu');
              },
            )
          ],
        ),
      ),
    );
  }
}