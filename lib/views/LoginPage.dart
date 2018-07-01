import 'dart:async';

import 'package:flutter/material.dart';
import 'package:material_manage_app/models/UserModel.dart';
import 'package:material_manage_app/util/LoginUtils.dart';
import 'package:material_manage_app/views/HomePage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  bool _isLoading = false;

  UserModel user = new UserModel();

  @override
  Widget build(BuildContext context) {
    final appName = Text(
      '武汉物资管理系统',
      textAlign: TextAlign.center,
      style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
    );

    final avatar = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      initialValue: 'ZSN',
      validator: (val) => (val == null || val.isEmpty) ? "请输入账号" : null,
      onSaved: (String text) => user.avatar = text,
      decoration: InputDecoration(
        hintStyle: new TextStyle(
          fontSize: 20.0,
        ),
        labelText: '账 户',
      ),
    );
    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      initialValue: '123456',
      validator: (val) => (val == null || val.isEmpty) ? "请输入密码" : null,
      onSaved: (String text) => user.password = text,
      decoration: InputDecoration(
        labelText: '密 码',
      ),
    );

    Future<dynamic> _signInWithEmailAndPassword() async {
      try {
        final form = _formKey.currentState;
        if (form.validate()) {
          setState(() {
            _isLoading = true;
          });
          _formKey.currentState.save();
          LoginUtils.login(user.avatar, user.password, (isAlive, userInfo) {
            if (isAlive) {
              Navigator.of(context).push(new PageRouteBuilder(
                  pageBuilder: (BuildContext context, _, __) {
                    return HomePage(user: userInfo);
                  }));
            } else {
              showDialog(
                context: context,
                child: new AlertDialog(
                  title: new Text('登录失败'),
                  content: new Text('用户名或密码错误，请重新登录。'),
                  actions: <Widget>[
                    new FlatButton(
                      onPressed: () {
                        setState(() {
                          _isLoading = false;
                        });
                        form.reset();
                        Navigator.of(context).pop(false);
                      },
                      child: new Text('OK'),
                    ),
                  ],
                ),
              ) ??
                  false;
            }
          });
        }
      } catch (e) {
        Navigator.of(context).pushNamed('/home');
      }
    }

    final login = Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Material(
          borderRadius: BorderRadius.circular(30.0),
          shadowColor: Colors.lightGreen.shade800,
          elevation: 4.0,
          child: MaterialButton(
            minWidth: 400.0,
            height: 52.0,
            onPressed: () => _signInWithEmailAndPassword(),
            color: Colors.green,
            splashColor: Colors.green.shade400,
            child: _isLoading
                ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 2.0,
            )
                : Text(
              '登录',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
        ));

    final form = Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          appName,
          SizedBox(height: 40.0),
          avatar,
          SizedBox(height: 8.0),
          password,
          SizedBox(height: 20.0),
          login,
        ],
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(left: 48.0, right: 48.0),
        child: form,
      ),
    );
  }
}
