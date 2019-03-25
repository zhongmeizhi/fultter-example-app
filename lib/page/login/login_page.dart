import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  final String title;
  LoginPage({Key key, this.title}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Z.登陆'),
      ),
      backgroundColor: Colors.white,
      body: new Container(
        child: _loginFormWidget(),
      ),
    );
  }
}

Widget _loginFormWidget () {

  Function _checkPhoneNum = (val) => {
//    if (val.length == 11) {
//      _isLoginAble =  _submitLogin
//    } else {
//      _isLoginAble = null
//    }
  };

  Object _isLoginAble;

  Function _submitLogin = () => {
    print('登陆')
  };

  return Center(
    child:  Padding(
      padding: EdgeInsets.all(ScreenUtil().setWidth(19)),
      child: Column(
        children: <Widget>[
          Image.asset('assets/images/logo.jpg', width: ScreenUtil().setWidth(70), height: ScreenUtil().setWidth(91)),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setWidth(15), bottom: ScreenUtil().setWidth(40)),
            child: Text(
              '金服互联网金融平台',
              style: TextStyle(color: Color(0xFFb3b3b3)),
            ),
          ),
          TextField(
              autofocus: false,
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(
                  labelText: "手机号",
                  hintText: "",
                  prefixIcon: Icon(Icons.phone_iphone)
              ),
              onChanged: (val) {
                _checkPhoneNum(val);
              },
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setWidth(25)),
            child: SizedBox(
              width: ScreenUtil().setWidth(335),
              height: ScreenUtil().setWidth(40),
              child: FlatButton(
                child: Text("下一步"),
                color: Color(0xFFed4e39),
                textColor: Colors.white,
                disabledColor: Color(0xFFDDDDDD),
                disabledTextColor:Color(0xFF8c8c8c) ,
                onPressed: _isLoginAble,
              ),
            )
          )
        ],
      )
    ),
  );
}