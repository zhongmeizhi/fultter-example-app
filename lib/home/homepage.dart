import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFFF4F4F4),
      body: new Container(
        // padding: const EdgeInsets.all(0),
        // margin: const EdgeInsets.all(0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // TODO 屏幕适配
            new Image.asset('assets/images/banner360.jpg', width: 414, height: 160),
            _bannerWidget(), 
          ],
        )
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