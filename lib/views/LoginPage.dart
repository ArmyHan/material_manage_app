import 'package:flutter/material.dart';
import 'package:material_manage_app/models/UserModel.dart';

class LoginPage extends StatefulWidget {
  LoginPageState createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
    UserModel user = new UserModel();

    return new Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 50.0, right: 50.0),
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  onSaved: (String text) => user.avatar = text,
                  decoration: InputDecoration(
                      hintText: '账 号',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0)),
                )
              ],
            )),
      ),
    );
  }
}
