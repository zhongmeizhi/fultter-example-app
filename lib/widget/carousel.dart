
import 'package:flutter/material.dart';

// Widget代码
class Carousel extends StatefulWidget {

  final List<Widget>  carouselList;  // 轮播图list
  final double height;  // 轮播图高度
  final double tagWidth; // 屏幕宽度
  final double tagBottom; // 下标 位置
  final Color tagColor; // 下标 颜色
  final Color activeTagColor; // 当前 下标 颜色
  final double tagSize; // 下标大小
  
  Carousel({
    this.height = 150.00,
    @required this.carouselList,
    @required this.tagWidth,
    this.tagBottom = 20.00,
    this.tagColor = Colors.white,
    this.activeTagColor = Colors.black,
    this.tagSize = 10.0,
  });

  @override
  State<StatefulWidget> createState() => _Carousel();

}

class _Carousel extends State<Carousel> with SingleTickerProviderStateMixin{

  List _wrapList = <Widget>[];

  // 页面控制器和下标控制器
  TabController  _tabController;
  PageController _pageController = PageController(initialPage: 1);

  @override
  void initState() {
    // 初始化时把list前后各加一张用于无限轮播
    _wrapList.insert(0, widget.carouselList[widget.carouselList.length - 1]);
    _wrapList.addAll(widget.carouselList);
    _wrapList.add(widget.carouselList[0]);
    _tabController = TabController(vsync: this, length: widget.carouselList.length);
    super.initState();
  }

  @override
  void dispose() {
    // 离开需销毁
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  _onPageChanged (idx) {
    // 轮播实现
    if (idx == 0) {
      _pageController.jumpToPage(_wrapList.length - 2);
      _pageController.animateToPage(
        _wrapList.length - 2,
        duration: Duration(microseconds: 666),
        curve: Curves.fastOutSlowIn
      );
    } else if (idx == (_wrapList.length - 1)) {
      _tabController.animateTo(0);
      _pageController.jumpToPage(1);
    } else {
      _tabController.animateTo(idx - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: widget.height,
          child: PageView(
            onPageChanged: _onPageChanged,
            children: _wrapList,
            controller: _pageController
          ),
        ),
        Positioned(
          bottom:  widget.tagBottom,
          child: Container(
            width: widget.tagWidth,
            child: Align(
              alignment: Alignment(0.0, 0.5),
              child: TabPageSelector(
                color: widget.tagColor,
                indicatorSize: widget.tagSize,
                selectedColor: widget.activeTagColor,
                controller: _tabController,
              ),
            ),
          )
        )
      ],
    );
  }

}