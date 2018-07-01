import 'package:flutter/material.dart';
import 'package:material_manage_app/models/UserModel.dart';
import 'package:material_manage_app/util/DataUtils.dart';
import 'package:material_manage_app/views/HomePage.dart';
import 'package:material_manage_app/views/LoginPage.dart';

void main() {
  DataUtils.getUserInfo().then((userInfo) {
    runApp(MyApp(userInfo));
  });
}

class MyApp extends StatelessWidget {
  MyApp(this.userModel);

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MaterialManagement',
      theme: ThemeData(
          accentColor: Colors.orange, primaryColor: Colors.blue
      ),
      home: HomePage(
        user: userModel,
      ),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => LoginPage(),
        '/home': (BuildContext context) => HomePage()
      },
    );
  }
}
