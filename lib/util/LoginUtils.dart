import 'package:material_manage_app/Api/APi.dart';
import 'package:material_manage_app/models/UserModel.dart';
import 'package:material_manage_app/util/DataUtils.dart';
import 'package:material_manage_app/util/HttpUtils.dart';

typedef LoginCallback(bool isAlive, UserModel user);

class LoginUtils {
  static void login(
      String avatar, String password, LoginCallback loginCallback) {
    Map<String, String> tokenParams = new Map();
    tokenParams['id'] = '3';
    tokenParams['password'] = '123456';
    HttpUtils.get(Api.TOKEN, (resultMap) {
      String token = resultMap["token"];
      Map<String, String> loginParams = new Map();
      loginParams['token'] = token;
      loginParams['source'] = 'amili';
      loginParams['avatar'] = avatar;
      loginParams['password'] = password;
      HttpUtils.post(Api.LOGIN, (resultMap) {
        DataUtils.saveUserInfo(resultMap).then((userInfo) {
          DataUtils.isAlive().then((isAlive) {
            return loginCallback(isAlive, userInfo);
          });
        });
      }, params: loginParams);
    }, params: tokenParams);
  }
}
