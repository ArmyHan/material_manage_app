import 'package:flutter/material.dart';
import 'package:material_manage_app/components/MyListView.dart';

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new MyListView(),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
