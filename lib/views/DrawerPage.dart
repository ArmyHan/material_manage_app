import 'package:flutter/material.dart';
import 'package:material_manage_app/models/UserModel.dart';

class DrawerPage extends StatelessWidget {
  DrawerPage({Key key, this.user}) : super(key: key);
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: new Text(user.avatar),
            accountEmail: new Text(user.email),
            currentAccountPicture: new GestureDetector(
              child: new CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child: new Text(
                  user.avatar.length > 2
                      ? user.avatar.substring(1)
                      : user.avatar.substring(0),
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
              title: new Text('登录'),
              trailing: new Icon(Icons.arrow_right),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/login');
              }),
          new ListTile(
              title: new Text('主界面'),
              trailing: new Icon(Icons.arrow_right),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/home');
              }),
          new Divider(),
          new ListTile(
              title: new Text('退出'),
              trailing: new Icon(Icons.exit_to_app),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/login');
              }),
        ],
      ),
    );
  }
}
