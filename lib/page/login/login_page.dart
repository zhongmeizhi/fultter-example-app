import 'package:zmz_app/compose/compose.dart';
import 'package:zmz_app/routes/z_router.dart';
// storage
import 'package:zmz_app/utils/storage.dart';

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

    String _formTip = ZRouter.getPageArguments<String>(context, '亲，没内容呢');
    
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
        height: ZFit().setWidth(30),
        padding: ZEdge.vertical_5,
        alignment: Alignment.center,
        child: Text(_formTip),
      )
    );
  }
}

Widget _loginFormWidget (_checkPhoneNum, _submitLogin) {

  return Center(
    child:  Padding(
      padding: ZEdge.all_15,
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
                color: ZColor.thinBlue,
                textColor: Colors.white,
                disabledColor: ZColor.grey,
                disabledTextColor: ZColor.black ,
                onPressed: _submitLogin()
              ),
            )
          )
        ],
      )
    ),
  );
}