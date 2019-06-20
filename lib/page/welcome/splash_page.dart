
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter_app/page/main_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{

  AnimationController _controller;
  Animation _animation;
  int _count = 5;
  TimerUtil _timerUtil;

  @override
  void initState() {
    _doCountDown();
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 2000));
    _animation = Tween(begin: 0.8, end: 1.0).animate(_controller);

    _animation.addStatusListener((status) {
      if (status ==AnimationStatus.completed) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MainPage()), (route) => route == null);
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 开屏广告结束，跳转到首页
  void _goMain() {
    Navigator.pushReplacementNamed(context, '/main_page');
  }

  void _doCountDown() {
    _timerUtil = new TimerUtil(mTotalTime: 3 * 1000);
    _timerUtil.setOnTimerTickCallback((int tick) {
      // 如果已经被销毁，那么不执行
      if (!mounted) {
        return;
      }
      double _tick = tick / 1000;
      setState(() {
        _count = _tick.toInt(); 
      });
      if (_tick == 0) {
        _goMain();
      }
    });
    _timerUtil.startCountDown();
  }

  @override
  Widget build(BuildContext context) {

    // 初始化页面 width=750; height=1334;
    ScreenUtil.instance = ScreenUtil(width: 375, height: 812)..init(context);

    return new Material(
      child: new Stack(
        children: <Widget>[
          new FadeTransition(
            opacity: _animation,
            child: new Image.asset(
              'assets/images/projector.png',
              width: double.infinity,
              fit: BoxFit.fill,
              height: double.infinity,
            ),
          ),
          Positioned(
            top: ScreenUtil().setWidth(33),
            right: ScreenUtil().setWidth(11),
            child: new Container(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: () {
                  _goMain();
                },
                child: new Container(
                  padding: EdgeInsets.all(12),
                  child: new Text('跳过 $_count s', style: new TextStyle(fontSize: ScreenUtil().setSp(12), color: Colors.white),),
                  decoration: new BoxDecoration(
                    color: Color(0x66000000),
                    borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(6))),
                    border: new Border.all(
                      width: ScreenUtil().setWidth(1),
                      color: Colors.blue[50],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}