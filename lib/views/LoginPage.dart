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
    bool _isLoading = false;

    return new Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 50.0, right: 50.0),
        margin: EdgeInsets.only(top: 130.0),
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
                ),
                SizedBox(height: 8.0),
                TextFormField(
                    autofocus: false,
                    obscureText: true,
                    onSaved: (String text) => user.password = text,
                    decoration: InputDecoration(
                      hintText: '密 码',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    )),
                SizedBox(height: 8.0),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Material(
                      shadowColor: Colors.blue,
                      elevation: 4.0,
                      child: MaterialButton(
                        minWidth: 400.0,
                        height: 42.0,
                        /*onPressed: () => Navigator.of(context).push(
                                new PageRouteBuilder(
                                    pageBuilder: (BuildContext context, _, __) {
                              return new ListPage(title: "武汉物资管理系统");
                            })),*/
                        onPressed: () =>
                            Navigator.pushReplacementNamed(context, "/home"),
                        color: Colors.blue,
                        splashColor: Colors.blue,
                        child: _isLoading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                                strokeWidth: 2.0,
                              )
                            : Text(
                                '登  录',
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                    ))
              ],
            )),
      ),
    );
  }
}
