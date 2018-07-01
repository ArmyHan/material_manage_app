import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:material_manage_app/util/DataUtils.dart';

class HttpUtils {
  HttpUtils._();

  static void get(String url, Function callback,
      {Map<String, String> params, Function errorCallback}) async {
    if (params != null && params.isNotEmpty) {
      StringBuffer sb = new StringBuffer("?");
      params.forEach((key, value) {
        sb.write("$key" + "=" + "$value" + "&");
      });
      String paramStr = sb.toString();
      paramStr = paramStr.substring(0, paramStr.length - 1);
      url += paramStr;
    }
    try {
      DataUtils.getJSessionId().then((JSessionId) {
        if (JSessionId != null) {
          http.get(url, headers: {'Cookie': 'JSESSIONID=' + JSessionId}).then(
              (response) {
            if (callback != null) {
              callback(jsonDecode(response.body));
            }
          });
        } else {
          http.get(url).then((response) {
            if (callback != null) {
              callback(jsonDecode(response.body));
            }
          });
        }
      });
    } catch (exception) {
      if (errorCallback != null) {
        errorCallback(exception);
      }
    }
  }

  static void post(String url, Function callback,
      {Map<String, String> params, Function errorCallback}) async {
    try {
      DataUtils.getJSessionId().then((JSessionId) {
        if (JSessionId != null) {
          http
              .post(url,
                  headers: {'Cookie': 'JSESSIONID=' + JSessionId}, body: params)
              .then((response) {
            if (callback != null) {
              callback(jsonDecode(response.body));
            }
          });
        } else {
          http.post(url, body: params).then((response) {
            if (callback != null) {
              callback(jsonDecode(response.body));
            }
          });
        }
      });
    } catch (e) {
      if (errorCallback != null) {
        errorCallback(e);
      }
    }
  }
}
