import 'package:flutter/material.dart';
import 'package:material_manage_app/components/InputField.dart';
import 'package:material_manage_app/models/UserModel.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
    bool _isLoading = false;
    UserModel user = new UserModel();
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InputField(
              hint: '账 号',
              obscure: false,
              icon: Icons.person,
              onSaveCallback: (String text) => user.avatar = text,
            ),
            InputField(
              hint: '密 码',
              obscure: true,
              icon: Icons.lock_outline,
              onSaveCallback: (String text) => user.password = text,
            ),
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
                            strokeWidth: 1.8,
                          )
                        : Text(
                            '登  录',
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ))
          ],
        ));
  }
}
