import 'package:flutter/material.dart';
import 'package:material_manage_app/components/LoginForm.dart';
import 'package:material_manage_app/style/LoginStyle.dart';

class LoginPage extends StatefulWidget {
  LoginPageState createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  AnimationController _loginButtonController;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        decoration: new BoxDecoration(
          image: backgroundImage,
        ),
        child: new Container(
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
            colors: <Color>[
              const Color.fromRGBO(162, 146, 199, 0.8),
              const Color.fromRGBO(51, 51, 63, 0.9),
            ],
            stops: [0.2, 1.0],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.0, 1.0),
          )),
          padding: EdgeInsets.only(left: 50.0, right: 50.0, top: 120.0),
          child: new LoginForm(),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loginButtonController = new AnimationController(
        duration: new Duration(milliseconds: 3000), vsync: this);
  }
}
