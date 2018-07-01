import 'package:flutter/material.dart';
import 'package:material_manage_app/util/AppUtils.dart';

class MessageListPage extends StatefulWidget {
  @override
  _MessageListPageState createState() => new _MessageListPageState();
}

class _MessageListPageState extends State<MessageListPage> {
  final List<Map> messageList = new List();
  Map<String, Object> result = new Map();

  @override
  void initState() {
    super.initState();
    messageList.add(result);
  }

  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldHomeState,
      body: Center(
        child: messageList.length == 0
            ? emptyView("暂无未读消息")
            : new Container(
                child: new ListView.builder(
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return new Dismissible(
                        key: new ObjectKey(messageList[index]),
                        onDismissed: (DismissDirection direction) {
                          setState(() {
                            messageList.removeAt(index);
                          });
                          if (direction == DismissDirection.endToStart) {
                            showSnackBar(_scaffoldHomeState, "消息已读",
                                materialColor: Colors.green);
                          } else {
                            showSnackBar(_scaffoldHomeState, "已删除",
                                materialColor: Colors.red);
                          }
                        },
                        background: new Container(
                          color: Colors.red,
                          child: new ListTile(
                            leading:
                                new Icon(Icons.delete, color: Colors.white),
                          ),
                        ),
                        secondaryBackground: new Container(
                          color: Colors.green,
                          child: new ListTile(
                            trailing:
                                new Icon(Icons.check, color: Colors.white),
                          ),
                        ),
                        child: Column(
                          children: <Widget>[
                            new Container(
                              margin: const EdgeInsets.symmetric(vertical: 2.0),
                              child: new Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, bottom: 4.0),
                                      child: new Text('消息标题',
                                          style: new TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    new Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, bottom: 4.0),
                                      child: new Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              '这里显示消息内容信息。',
                                              maxLines: 2,
                                              style: new TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14.0),
                                              key: new Key("Date"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
      ),
    );
  }
}
