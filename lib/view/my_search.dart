import 'package:flutter/material.dart';

class MySearch extends SearchDelegate {

  var _searchValue;

  MySearch(this._searchValue);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      BackButton()
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    // 通过this调用SearchDelegate源码中的 query
    Map map = {
      '111': '搜索到一条结果'
    };

    String _result = map[this.query] ?? '未搜索到结果';

    // 搜索结果
    return ListTile(
      title: Text(_result)
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // 搜索建议
    return Column(
      children: List.generate(4, (index) => ListTile(
          title: Text('Suggestions 00' + index.toString()),
          onTap: (){
            // 修改SearchDelegate的 query
            this.query = 'Suggestions 00' + index.toString();
            // 调用SearchDelegate的显示结果方法
            this.showResults(context);
          },
        )).toList()
    );
  }

  @override
  Widget buildLeading(BuildContext context) {
    // 搜索Icon
    return RaisedButton(
      child: Icon(Icons.search),
      color: Colors.white,
      onPressed: (){ // 点击搜索按钮
        // 调用SearchDelegate的显示结果方法
        this.showResults(context);
      },
    );
  }

}