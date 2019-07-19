import 'package:flutter/material.dart';
import 'package:zmz_app/components/toast.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewsState();
}

class _NewsState extends State<NewsPage> {
  var products = List.generate(16, (idx) => idx);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Z.新闻'),
      //   centerTitle: true, // appBar文字居中
      // ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Row(
              children: <Widget>[
                Text('Z.新闻')
              ],
            ),
            // centerTitle: true, // 让center居中，android表示变化不大
            // iconTheme: IconThemeData(), // Icon的样式
            actions: <Widget>[ //导航栏右侧菜单
              IconButton(icon: Icon(Icons.search), onPressed: () {
                
                }
              ),
            ],
            // bottom: PreferredSize(  // appBar 中间底部widget
            //   preferredSize: Size(0.0, 0.0),
            //   child: Text('bottom')
            // ),
            backgroundColor: Theme.of(context).accentColor,
            expandedHeight: 160.0, // 图片高度
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset('assets/images/news.jpg', fit: BoxFit.cover),
            ),
            floating: true,
            snap: true, // 必须要 floating: true 才能使用，snap时在下拉手势松开后直接展示图片
            pinned: true, // 图片消失时 title 是否可见
          ),
          // SliverGrid 的使用方法
          // xxx
          // SliverGrid.count( // SliverGrid和Grid有什么区别？？？
          //   crossAxisCount: 2,  // 一行排列数
          //   mainAxisSpacing: 15.0,  // 主轴间隔
          //   // crossAxisSpacing: 6.0, // 交叉轴间隔
          //   childAspectRatio: 2.3, // 纵横比
          //   children: products.map((product) {
          //     return Container(
          //       margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(12)),
          //       decoration: BoxDecoration( // 阴影修饰
          //         color: Colors.white,
          //         boxShadow: [
          //           BoxShadow(color: Colors.blue, offset: Offset(0, 5.0), blurRadius: 6.0, spreadRadius: -5.0),
          //           BoxShadow(color: Colors.pink, offset: Offset(-5.0, 0.0), blurRadius: 6.0, spreadRadius: -5.0)
          //         ]
          //       ),
          //       child: ListTile(
          //         leading: Container(
          //           decoration: BoxDecoration(  // 渐变修饰
          //             shape: BoxShape.circle,
          //             gradient: RadialGradient(
          //               colors: [Colors.orange, Colors.green, Colors.orange]
          //             ),
          //           ),
          //           child: Icon(Icons.equalizer),
          //         ),
          //         title: Text('...' + product.toString()),
          //         subtitle: Text('啦啦啦'),
          //       ),
          //     );
          //   }).toList(),
          // ),
          SliverFixedExtentList(
            itemExtent: 66.0, // 高度
            delegate: SliverChildListDelegate(
              products.map((product) {
                return ListTile(
                  leading: Icon(Icons.equalizer),
                  title: Text('...' + product.toString()),
                  subtitle: Text('啦啦啦'),
                  onTap: () {
                    Toast.show(context, '点击：' + product.toString());
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
  
}