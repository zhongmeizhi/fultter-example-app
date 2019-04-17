import 'package:flutter/material.dart';

class FundSelectionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FundState();
}

class FundState extends State<FundSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text('进入-> WebView', style: TextStyle(fontSize: 22.0),),
      textColor: Colors.deepOrange,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onPressed: () {
        Navigator.pushNamed(context, '/baidu');
      },
    );
  }
}