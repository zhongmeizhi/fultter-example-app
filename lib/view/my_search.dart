import 'package:flutter/material.dart';

class MySearch extends SearchDelegate {

  var _searchValue;

  MySearch(this._searchValue);


  @override
  List<Widget> buildActions(BuildContext context) {
    print(_searchValue);
    
    return [
      RawMaterialButton(
        constraints: BoxConstraints(minWidth: 50.0, minHeight: 36.0),
        child: Icon(Icons.close),
        onPressed: () {
          this.query = '';
        },
      ),
      RawMaterialButton(
        constraints: BoxConstraints(minWidth: 50.0, minHeight: 36.0),
        child: Text('取消'),
        onPressed: () {
          Navigator.maybePop(context);
        },
      )
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    if (this.query == '') {
      return Container();
    } else {
      List _data = List.generate(12, (idx) => idx);
      // 搜索结果
      return GridView.builder(
        itemCount: _data.length,
        //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //横轴元素个数
          crossAxisCount: 2,
          //纵轴间距
          mainAxisSpacing: 20.0,
          //横轴间距
          crossAxisSpacing: 10.0,
          //子组件宽高长度比例
          childAspectRatio: 1.0
        ),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: Colors.cyan.withAlpha(55),
          child: Center(
            child: Text('${this.query}的搜索结果 ${index.toString()}'),
          )
        );
      });
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // 搜索建议
    return Column(
      children: List.generate(4, (index) {
        String _text = '${this.query == '' ? '猜你喜欢' : this.query} - ${index.toString()} ';
        // 搜索建议list
        return ListTile(
          title: Text(_text),
          onTap: (){
            // 修改SearchDelegate的 query
            this.query = _text;
            // 调用SearchDelegate的显示结果方法
            this.showResults(context);
          },
        );
      }).toList()
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