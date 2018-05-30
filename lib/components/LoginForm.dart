import 'package:flutter/material.dart';
import 'package:material_manage_app/components/InputField.dart';
import 'package:material_manage_app/components/LoginButton.dart';
import 'package:material_manage_app/models/UserModel.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
    bool _isLoading = false;
    UserModel user = new UserModel(null, null);
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
            LoginButton(),
          ],
        ));
  }
}
