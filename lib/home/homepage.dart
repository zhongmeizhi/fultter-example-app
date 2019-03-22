import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            new Image.asset('assets/images/banner360.jpg', width: ScreenUtil().setWidth(750), height: ScreenUtil().setWidth(292)),
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