import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class MyListView extends StatefulWidget {
  @override
  MyListViewState createState() => new MyListViewState();
}

class MyListViewState extends State<MyListView> {
  var data;

  @override
  void initState() {
    //TODO 导航到该界面之前获取data数据.
    getDetailList();
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(
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
                            data[index]["title"],
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
                            data[index]["body"],
                            style: new TextStyle(fontSize: 12.0),
                          ))
                        ],
                      ),
                      new Row(
                        children: <Widget>[
                          new Container(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 2.0),
                            child:
                                new Text('id' + data[index]["id"].toString()),
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

  getDetailList() async {
    var url = 'https://jsonplaceholder.typicode.com/posts';
    var httpClient = new HttpClient();

    var result;
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.OK) {
        var json = await response.transform(UTF8.decoder).join();
        result = JSON.decode(json);
      } else {
        result = 'Error getting JSON data:\nHttp status ${response.statusCode}';
      }
    } catch (exception) {
      result = 'Failed getting JSON data.';
    }

    if (!mounted) return;

    setState(() {
      data = result;
    });
  }
}
