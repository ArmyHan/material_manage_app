import 'package:flutter/material.dart';
import 'package:material_manage_app/views/HomePage.dart';
import 'package:material_manage_app/views/LoginPage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: '武汉物资管理系统'),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => new LoginPage(),
        '/home': (BuildContext context) => new MyHomePage()
      },
    );
  }
}
