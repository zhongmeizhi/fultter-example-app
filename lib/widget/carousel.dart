
import 'package:flutter/material.dart';
import 'dart:async';

// Widget代码
class Carousel extends StatefulWidget {

  final List<Widget>  carouselList;  // 轮播图list
  final double height;  // 轮播图高度
  final double tagWidth; // 屏幕宽度
  final double tagBottom; // 下标 位置
  final Color tagColor; // 下标 颜色
  final Color activeTagColor; // 当前 下标 颜色
  final double tagSize;
  final bool isAuto;  // 是否自动轮播
  final int interval; // 自动轮播间隔
  
  Carousel({
    this.height = 150.00,
    @required this.carouselList,
    @required this.tagWidth,
    this.tagBottom = 6.00,
    this.tagColor = Colors.white,
    this.activeTagColor = Colors.grey,
    this.tagSize = 10.0,
    this.isAuto = true,
    this.interval = 3
  });

  @override
  State<StatefulWidget> createState() => _Carousel();

}

class _Carousel extends State<Carousel> with SingleTickerProviderStateMixin{

  List _wrapList = <Widget>[];

  // 页面控制器和下标控制器
  TabController  _tabController;
  PageController _pageController = PageController(initialPage: 1);

  // 计时器
  Timer _timer;

  _onPageChanged (idx) {
    // 轮播实现
    if (idx == 0) {
      int _endIndex = _wrapList.length - 2;
      _pageController.animateToPage(
        _endIndex,
        duration: Duration(microseconds: 1688),
        curve: Curves.fastOutSlowIn
      );
    } else if (idx == (_wrapList.length - 1)) {
      int _startIndex = 1;
      _pageController.animateToPage(
        _startIndex,
        duration: Duration(microseconds: 1688),
        curve: Curves.fastOutSlowIn
      );
    } else {
      _tabController.animateTo(idx - 1);
    }
  }

  // 自动轮播
  _autoSwiper () {
    // 使用计时器
    _timer = new Timer.periodic(
      Duration(seconds: widget.interval),
      (timer){
        // 下个页面
        int _next = (_tabController.index ?? 1 + 1) % _tabController.length; 
        _pageController.animateToPage(
          _next, 
          duration: Duration(milliseconds: 168),
          curve: Curves.fastOutSlowIn,
        );
      }
    );
  }

  @override
  void initState() {
    // 初始化时把list前后各加一张用于无限轮播
    _wrapList.insert(0, widget.carouselList[widget.carouselList.length - 1]);
    _wrapList.addAll(widget.carouselList);
    _wrapList.add(widget.carouselList[0]);
    _tabController = TabController(vsync: this, length: widget.carouselList.length);
    // 自动滑动
    if (widget.isAuto) {
      _autoSwiper();
    }
    super.initState();
  }

  @override
  void dispose() {
    // 销毁 控制器
    _tabController.dispose();
    _pageController.dispose();
    // 清理计时器
    if (_timer != null) {
      _timer.cancel();
    }
    super.dispose();
  }

  // 利用PageView实现
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