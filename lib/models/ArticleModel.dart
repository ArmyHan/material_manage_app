import 'dart:convert';

class ArticleModel {
  int userId;
  int id;
  String title;
  String body;

  ArticleModel(this.userId, this.id, this.title, this.body);

  static List<ArticleModel> allFromResponse(List responseList) {
    return responseList
        .map((it) =>
            new ArticleModel(it["userId"], it["id"], it["title"], it["body"]))
        .toList();
  }
}
