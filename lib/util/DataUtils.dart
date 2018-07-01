import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:material_manage_app/models/UserModel.dart';

class DataUtils {
  DataUtils._();

  static final String J_SESSION_ID = "jSessionId";
  static final String IS_ALIVE = "isAlive";

  static final String USER_NAME = "userName";
  static final String USER_AVATAR = "userAvatar";
  static final String USER_MEMO = "userMemo";

  static Future<UserModel> saveUserInfo(Map data) async {
    if (data != null && data["success"]) {
      SharedPreferences sp = await SharedPreferences.getInstance();
      String name = data['name'];
      String avatar = data['avatar'];
      String memo = data['memo'];
      String JSessionId = data['JSessionId'];
      await sp.setString(USER_NAME, name);
      await sp.setString(USER_AVATAR, avatar);
      await sp.setString(USER_MEMO, memo);
      await sp.setString(J_SESSION_ID, JSessionId);
      await sp.setBool(IS_ALIVE, true);
      UserModel userInfo =
          new UserModel(avatar: avatar, name: name, memo: memo);
      return userInfo;
    }
    return null;
  }

  static clearLoginInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString(USER_NAME, null);
    await sp.setString(USER_AVATAR, null);
    await sp.setString(USER_MEMO, null);
    await sp.setString(J_SESSION_ID, null);
    await sp.setBool(IS_ALIVE, false);
  }

  static Future<UserModel> getUserInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool isLogin = sp.getBool(IS_ALIVE);
    if (isLogin == null || !isLogin) {
      return null;
    }
    UserModel user = new UserModel(
        avatar: sp.getString(USER_AVATAR),
        name: sp.getString(USER_NAME),
        memo: sp.get(USER_MEMO));
    return user;
  }

  static Future<bool> isAlive() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool b = sp.getBool(IS_ALIVE);
    return b != null && b;
  }

  static Future<String> getJSessionId() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(J_SESSION_ID);
  }
}
