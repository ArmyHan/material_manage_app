import 'dart:async';
import 'dart:io';

import 'package:local_notifications/local_notifications.dart';
import 'package:material_manage_app/Api/APi.dart';

class MessageUtils {
  static WebSocket _webSocket;
  static num _id = 0;

  static void connect() {
    Future<WebSocket> futureWebSocket =
        WebSocket.connect(Api.WS_URL + "/wujianchuan");
    futureWebSocket.then((WebSocket ws) {
      _webSocket = ws;
      _webSocket.readyState;

      void onData(dynamic content) {
        _id++;
        _sendMessage("收到");
        _createNotification("新消息", content + _id.toString());
      }

      _webSocket.listen(onData,
          onError: (a) => print("error"), onDone: () => print("done"));
    });
  }

  static void closeSocket() {
    _webSocket.close();
  }

  static void _sendMessage(String message) {
    _webSocket.add(message);
  }

  static void _createNotification(String title, String content) async {
    await LocalNotifications.createNotification(
      id: _id,
      title: title,
      content: content,
      onNotificationClick: new NotificationAction(
          actionText: "some action",
          callback: _onNotificationClick,
          payload: "接收成功！"),
    );
  }

  static _onNotificationClick(String payload) {
    LocalNotifications.removeNotification(_id);
    _sendMessage("消息已被阅读");
  }
}
