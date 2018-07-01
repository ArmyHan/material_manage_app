import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:local_notifications/local_notifications.dart';
import 'package:material_manage_app/models/UserModel.dart';
import 'package:material_manage_app/util/DataUtils.dart';
import 'package:material_manage_app/util/MessageUtils.dart';

class DrawerPage extends StatelessWidget {
  DrawerPage({Key key, this.user}) : super(key: key);
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: new Text(user.name),
            accountEmail: null,
            currentAccountPicture: new GestureDetector(
              child: new CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child: new Text(
                  user.name.length > 2
                      ? user.name.substring(1)
                      : user.name.substring(0),
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                      letterSpacing: 2.0,
                      color: Colors.white),
                ),
              ),
            ),
            decoration: new BoxDecoration(
              image: new DecorationImage(
                fit: BoxFit.fill,
                image: new ExactAssetImage('assets/background/login.jpg'),
              ),
            ),
          ),
          new ListTile(
            title: new Text('我的消息'),
            leading: new Icon(Icons.chat),
            trailing: new Icon(Icons.chevron_right),
            onTap: () async {
              await LocalNotifications.createNotification(
                id: 0,
                title: '新消息',
                content: '献血服务科申请了物料请及时审核。',
                onNotificationClick: new NotificationAction(
                    actionText: "some action",
                    callback: (String playLoad) {
                      print(playLoad);
                    },
                    payload: "some payload"),
              );
            },
          ),
          new ListTile(
              title: new Text('扫码'),
              leading: new Icon(Icons.fullscreen),
              trailing: new Icon(Icons.chevron_right),
              onTap: () async {
                String barcode = await BarcodeScanner.scan();
                print(barcode);
              }),
          new Divider(),
          new ListTile(
              title: new Text('退出'),
              leading: new Icon(Icons.exit_to_app),
              onTap: () {
                DataUtils.clearLoginInfo();
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/login');
                MessageUtils.closeSocket();
              }),
        ],
      ),
    );
  }
}
