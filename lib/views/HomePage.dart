import 'package:flutter/material.dart';
import 'package:material_manage_app/components/MyListView.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _returnTop() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.exit_to_app),
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, "/login"))
        ],
      ),
      body: new Center(
        child: new MyListView(),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _returnTop,
        tooltip: '返回顶部',
        child: new Icon(Icons.vertical_align_top),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
