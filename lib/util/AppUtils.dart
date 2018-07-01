import 'package:flutter/material.dart';

showSnackBar(GlobalKey<ScaffoldState> scaffoldState, String message,
    {MaterialColor materialColor}) {
  if (message.isEmpty) return;
  scaffoldState.currentState.showSnackBar(
      new SnackBar(content: new Text(message), backgroundColor: materialColor));
}

Widget emptyView(String emptyMessage) {
  return new Center(
    child: new Text(emptyMessage,
        style: new TextStyle(fontSize: 18.0, color: Colors.black)),
  );
}
