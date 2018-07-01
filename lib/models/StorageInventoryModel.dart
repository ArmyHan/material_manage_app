class StorageInventoryModel {
  String uuid;
  String storageInventNumber;
  String inventorName;
  DateTime inventTime;

  static List<StorageInventoryModel> allFromResponse(List responseList) {
    return responseList.map((it) {
      StorageInventoryModel model = new StorageInventoryModel();
      model.uuid = it["uuid"];
      model.storageInventNumber = it["storageInventNumber"];
      model.inventorName = it["inventorName"];
      model.inventTime = DateTime.parse(it["inventTime"]);
      return model;
    }).toList();
  }

  static StorageInventoryModel fromResponse(Map resultMap) {
    StorageInventoryModel model = new StorageInventoryModel();
    model.uuid = resultMap["uuid"];
    model.storageInventNumber = resultMap["storageInventNumber"];
    model.inventorName = resultMap["inventorName"];
    model.inventTime = DateTime.parse(resultMap["inventTime"]);
    return model;
  }
}
