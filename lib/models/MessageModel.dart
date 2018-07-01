class MessageModel {
  final String senderName;
  final String sendTime;
  final String title;
  final String content;

  MessageModel({this.senderName, this.sendTime, this.title, this.content});

  MessageModel.fromJson(Map<String, dynamic> json)
      : senderName = json["senderName"],
        sendTime = json["sendTime"],
        title = json["title"],
        content = json["content"];

  Map<String, dynamic> toJson() => {
        'data': {
          'senderName': this.senderName,
          'sendTime': this.sendTime,
          'title': this.title,
          'content': this.content,
        }
      };
}
