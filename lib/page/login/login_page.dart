import 'package:zmz_app/compose/compose.dart';
// storage
import 'package:zmz_app/utils/storage.dart';
// 参数
import 'package:zmz_app/domain/route_argument.dart';

class LoginPage extends StatefulWidget {
  final String title;
  LoginPage({Key key, this.title}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String _phoneNum = '';

  void _checkPhoneNum(val) {
    setState(() {
      _phoneNum = val;
    });
  }

  _submitLogin () {
  if (_phoneNum.length == 11) {
      return () {
        LocalStorage.setString('phone', _phoneNum);
        // 登录成功
        Navigator.pop(context);
      };
    } else {
      return null;
    }
  }
  
  @override
  Widget build(BuildContext context) {

    // 接收RoutSetting的路由参数
    RouteArguments args = ModalRoute.of(context).settings.arguments ?? RouteArguments('title', 'message');
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Z.登陆'),
      ),
      backgroundColor: Colors.white,
      body: new ListView(
        children: <Widget>[
          _loginFormWidget(_checkPhoneNum, _submitLogin),
        ]
      ),
      // 小角落里面打印进入的地方，方便以后使用
      bottomSheet: Container(
        width: ZFit().setWidth(375),
        height: ZFit().setWidth(15),
        alignment: Alignment.center,
        child: Text(args.message),
      )
    );
  }
}

Widget _loginFormWidget (_checkPhoneNum, _submitLogin) {

  return Center(
    child:  Padding(
      padding: EdgeInsets.all(ZFit().setWidth(19)),
      child: Column(
        children: <Widget>[
          Image.asset('assets/images/logo.jpg', width: ZFit().setWidth(70), height: ZFit().setWidth(90)),
          Padding(
            padding: EdgeInsets.only(top: ZFit().setWidth(15), bottom: ZFit().setWidth(40)),
            child: Text(
              '互联网金融平台',
              style: TextStyle(color: Color(0xFFb3b3b3)),
            ),
          ),
          TextField(
              autofocus: false,
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(
                  labelText: "手机号",
                  hintText: "请输入11位手机号",
                  prefixIcon: Icon(Icons.phone_iphone)
              ),
              onChanged: (val) {
                _checkPhoneNum(val);
              },
          ),
          Padding(
            padding: EdgeInsets.only(top: ZFit().setWidth(25)),
            child: SizedBox(
              width: ZFit().setWidth(335),
              height: ZFit().setWidth(40),
              child: FlatButton(
                child: Text("下一步"),
                color: Color(0xFFed4e39),
                textColor: Colors.white,
                disabledColor: Color(0xFFDDDDDD),
                disabledTextColor:Color(0xFF8c8c8c) ,
                onPressed: _submitLogin()
              ),
            )
          )
        ],
      )
    ),
  );
}