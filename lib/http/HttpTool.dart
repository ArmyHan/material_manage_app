import 'dart:convert';
import 'dart:io';

class HttpTool{
  static get(url) async {
    var httpClient = new HttpClient();

    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.OK) {
        return await response.transform(UTF8.decoder).join();
      } else {
        print('Error getting JSON data:\nHttp status ${response.statusCode}');
      }
    } catch (exception) {
      print('Failed getting JSON data.');
    }
  }
}