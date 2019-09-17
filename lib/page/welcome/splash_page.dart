
import 'package:zmz_app/compose/compose.dart';
import 'package:common_utils/common_utils.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin{

  int _count = 5;
  TimerUtil _timerUtil;

  @override
  void initState() {
    super.initState();
    _doCountDown();
  }

  // 开屏广告结束，跳转到首页
  void _goMain() {
    Navigator.of(context).pushReplacementNamed('/main_page');
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

    return new Material(
      child: new Stack(
        children: <Widget>[
          new Image.asset(
            'assets/images/projector.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
          Positioned(
            top: ZFit().setWidth(33),
            right: ZFit().setWidth(11),
            child: new Container(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: _goMain,
                child: new Container(
                  padding: EdgeInsets.all(12),
                  child: new Text('跳过 $_count s', style: new TextStyle(fontSize: ZFit().setSp(12), color: Colors.white),),
                  decoration: new BoxDecoration(
                    color: Color(0x66000000),
                    borderRadius: ZRadius.all_5,
                    border: new Border.all(
                      width: ZFit().setWidth(1),
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