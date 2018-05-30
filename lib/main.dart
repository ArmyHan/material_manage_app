import 'package:flutter/material.dart';
import 'package:material_manage_app/views/HomePage.dart';
import 'package:material_manage_app/views/LoginPage.dart';
import 'package:local_notifications/local_notifications.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  void getNotification() async {
    await LocalNotifications.createNotification(
      id: 0,
      title: '新消息',
      content: '献血服务科申请了物料请及时审核。',
      onNotificationClick: new NotificationAction(
          actionText: "some action", callback: null, payload: "some payload"),
    );
  }

  @override
  Widget build(BuildContext context) {
    getNotification();
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new LoginPage(),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => new LoginPage(),
        '/home': (BuildContext context) => new HomePage()
      },
    );
  }
}
