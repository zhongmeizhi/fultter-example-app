import 'package:flutter/material.dart';

class TreasurePage extends StatefulWidget {
  @override
  TreasurePageState createState() => TreasurePageState();
}

class TreasurePageState extends State<TreasurePage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      body: Container(
        child: _userInfoWidget(),
      )
    );
  }
}

Widget _userInfoWidget () {
  return Center(
    child: Text(
      '一个富有的小青年.',
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}