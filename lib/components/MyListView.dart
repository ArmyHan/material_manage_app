import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:material_manage_app/http/HttpTool.dart';
import 'package:material_manage_app/models/ArticleModel.dart';

class MyListView extends StatefulWidget {
  @override
  MyListViewState createState() => new MyListViewState();
}

class MyListViewState extends State<MyListView> {
  List data = [];

  @override
  void initState() {
    //TODO 导航到该界面之前获取data数据.
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            elevation: 4.0,
            child: new Container(
              padding: new EdgeInsets.all(10.0),
              child: new ListTile(
                subtitle: new Container(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Expanded(
                              child: new Text(
                            data[index].title,
                            maxLines: 1,
                            style: new TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0),
                          ))
                        ],
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Expanded(
                              child: new Text(
                            data[index].body,
                            style: new TextStyle(fontSize: 12.0),
                          ))
                        ],
                      ),
                      new Row(
                        children: <Widget>[
                          new Container(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 2.0),
                            child: new Text('id' + data[index].id.toString()),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                trailing: new Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey,
                ),
              ),
            ),
          );
        });
  }

  getData() async {
    var url = 'https://jsonplaceholder.typicode.com/posts';
    var result = await HttpTool.get(url);
    if (!mounted) return;
    setState(() {
      data = ArticleModel.allFromResponse(jsonDecode(result));
    });
  }
}
