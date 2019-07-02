import 'package:flutter/material.dart';

class DealerSelectionPage extends StatefulWidget {
  @override
  _DealerSelectionPageState createState() => _DealerSelectionPageState();
}

class _DealerSelectionPageState extends State<DealerSelectionPage> {

  List<String> letterList = [
    "A", "B", "C", "D", 
    "E", "F", "G", "H", "I"
  ];

  @override
  Widget build(BuildContext context) {
    // 如果ReorderableListView在Container中，上层还用个TabsView
    // 会产生多个ScrollAble的Widget。导致ReorderableListView不能滚动
    return Scaffold(
      // 可再次排序的 ListView
      body: ReorderableListView(
        header: Text('拖动式重新排序', style: TextStyle(fontSize: 26),),
        children: letterList.map(_buildCard).toList(),
        onReorder: _onReorder,
      ),
    );
  }

  // 排序方式
  _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) newIndex -= 1;
      var item = letterList.removeAt(oldIndex);
      letterList.insert(newIndex, item);
    });
  }
}

Widget _buildCard(String name) {
  return Container(
    key: ObjectKey(name),
    height: 100,
    width: 200,
    child: Card(
      color: Colors.cyan.withAlpha(111),
      child: Center(
        child: Text(
          '$name',
          style: TextStyle(fontSize: 24, color: Colors.white,),
        ),
      ),
    ),
  );
}