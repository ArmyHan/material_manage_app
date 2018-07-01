import 'package:flutter/material.dart';
import 'package:material_manage_app/Api/APi.dart';
import 'package:material_manage_app/components/LoadingProgress.dart';
import 'package:material_manage_app/models/StorageInventoryModel.dart';
import 'package:material_manage_app/util/HttpUtils.dart';

class StorageInventoryDetailPage extends StatefulWidget {
  StorageInventoryDetailPage({Key key, this.uuid}) : super(key: key);
  final String uuid;

  @override
  _StorageInventoryDetailPageState createState() =>
      new _StorageInventoryDetailPageState();
}

class _StorageInventoryDetailPageState
    extends State<StorageInventoryDetailPage> {
  StorageInventoryModel _model;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("库存盘点"),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: _model == null ? new LoadingProgress() : _getBody(),
        ),
      ),
    );
  }

  _getBody() {
    return Column(
      children: <Widget>[
        Container(
          decoration:
              BoxDecoration(border: Border.all(width: 1.0, color: Colors.blue)),
          padding: EdgeInsets.all(20.0),
          child: Text("单号：" + _model.storageInventNumber),
        ),
      ],
    );
  }

  _loadData() {
    Map<String, String> params = {"uuid": widget.uuid};
    HttpUtils.get(Api.STORAGE_INVENTORY_DETAIL, (resultMap) {
      if (!mounted) return;
      setState(() {
        _model = StorageInventoryModel.fromResponse(resultMap["object"]);
      });
    }, params: params);
  }
}
