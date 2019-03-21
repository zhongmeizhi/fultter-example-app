import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  double screenWidth = 0.0;
  
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      body: new Container(
        child: _bannerWidget(),
      ),
    );
  }
}

Widget _bannerWidget () {
  return Container(
      color: Colors.red,
      child: Text(
        '首页banner',
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
}