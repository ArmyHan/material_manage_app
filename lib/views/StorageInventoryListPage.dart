import 'package:flutter/material.dart';
import 'package:material_manage_app/Api/APi.dart';
import 'package:material_manage_app/components/LoadingProgress.dart';
import 'package:material_manage_app/util/HttpUtils.dart';
import 'package:material_manage_app/models/StorageInventoryModel.dart';
import 'package:material_manage_app/views/StorageInventoryDetailPage.dart';

class StorageInventoryListPage extends StatefulWidget {
  @override
  _StorageInventoryListPageState createState() =>
      new _StorageInventoryListPageState();
}

class _StorageInventoryListPageState extends State<StorageInventoryListPage> {
  List<StorageInventoryModel> _dataList;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: _dataList == null ? LoadingProgress() : _getBody(),
      ),
    );
  }

  _getBody() {
    return ListView.builder(
        itemCount: _dataList == null ? 0 : _dataList.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 4.0,
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: ListTile(
                onTap: () => Navigator.of(context).push(
                      PageRouteBuilder(
                          pageBuilder: (BuildContext context, _, __) {
                        return StorageInventoryDetailPage(
                            uuid: _dataList[index].uuid);
                      }),
                    ),
                subtitle: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                              child: Text(
                            '单号：' + _dataList[index].storageInventNumber,
                            maxLines: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0),
                          ))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Expanded(
                              child: Text(
                            '盘点人：' + _dataList[index].inventorName,
                            style: TextStyle(fontSize: 12.0),
                          ))
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              '盘点时间：' + _dataList[index].inventTime.toString(),
                              style: new TextStyle(fontSize: 12.0),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey,
                ),
              ),
            ),
          );
        });
  }

  _loadData() {
    String filter =
        '[{"property":"startDate","value":"2017-06-04"},{"property":"endDate","value":"2018-06-04"}]';
    Map<String, String> params = {
      "source": "amili",
      "start": "0",
      "limit": "100",
      "filter": filter
    };

    HttpUtils.post(Api.STORAGE_INVENTORY_LIST, (resultMap) {
      if (!mounted) return;
      setState(() {
        _dataList = StorageInventoryModel.allFromResponse(resultMap["objects"]);
      });
    }, params: params);
  }
}
