import 'package:flutter/material.dart';
import 'package:flutter_app/unit/event_bus.dart';

class CustomerPage extends StatefulWidget {
  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {

  final EventBus bus = new EventBus();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      appBar: AppBar(
        title: Text('Z.我的'),
      ),
      body: new Container(
        child: _userInfoWidget(),
      ),
    );
  }
}

Widget _userInfoWidget () {
  return Center(
    child: Text(
      '这是你的...',
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}