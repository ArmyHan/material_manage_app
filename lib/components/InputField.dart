import 'package:flutter/material.dart';

typedef void OnSaveCallback(String text);

class InputField extends StatelessWidget {
  final String hint;
  final bool obscure;
  final IconData icon;
  final OnSaveCallback onSaveCallback;

  InputField({Key key, this.hint, this.obscure, this.icon, this.onSaveCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
          border: new Border(
              bottom: new BorderSide(
        width: 0.5,
        color: Colors.white24,
      ))),
      child: new TextFormField(
        obscureText: true,
        onSaved: onSaveCallback,
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: new InputDecoration(
            icon: new Icon(
              icon,
              color: Colors.white,
            ),
            border: InputBorder.none,
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white, fontSize: 16.0),
            contentPadding: const EdgeInsets.only(
                top: 30.0, right: 30.0, bottom: 20.0, left: 5.0)),
      ),
    );
  }
}
